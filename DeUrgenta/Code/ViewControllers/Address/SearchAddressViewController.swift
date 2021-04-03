//
//  SearchAddressViewController.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 02.04.2021.
//

import UIKit
import NMAKit
import SnapKit

class SearchAddressViewController: DUViewController {
    
    let model = SearchAddressViewModel()
    
    @IBOutlet weak var searchFieldContainer: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet var resultsTableView: UITableView!
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    private var map: NMAMapView!
    private var mapMarker: NMAMapMarker?
    private let zoomedOutLevel: Float = 8
    private let zoomedInLevel: Float = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDependencies()
        setupTableView()
        title = "Adaugă-ți adresa de domiciliu"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        updateSaveButton()
    }
    
    private func setupDependencies() {
        searchFieldContainer.backgroundColor = .mainAccent
        
        map = NMAMapView(frame: .zero)
        let geoCenterLocation = MapManager.defaultGeoCenter
        let geoCenter = NMAGeoCoordinates(
            latitude: geoCenterLocation.latitude, longitude: geoCenterLocation.longitude
        )
        map.set(geoCenter: geoCenter, animation: .none)
        map.set(zoomLevel: zoomedOutLevel, animation: .none)
        mapContainer.addSubview(map)
        map.snp.makeConstraints { make in
            make.edges.equalTo(mapContainer)
        }
    }
    
    private func setupTableView() {
        resultsTableView.register(UINib(nibName: SearchTableCell.nibName, bundle: nil),
                                  forCellReuseIdentifier: SearchTableCell.cellIdentifier)
    }
    
    private func updateMap() {
        if let mapMarker = mapMarker {
            map.remove(mapObject: mapMarker)
        }
        
        if let location = model.selectedLocation?.location {
            let geoCenter = NMAGeoCoordinates(
                latitude: location.latitude, longitude: location.longitude
            )
            map.set(geoCenter: geoCenter, zoomLevel: zoomedInLevel, animation: .linear)
            
            // TODO: make marker draggable
            self.mapMarker = NMAMapMarker(geoCoordinates: geoCenter, image: UIImage.mapPinIcon!)
            self.mapMarker?.anchorOffset = CGPoint(x: 0, y: -21)
//            self.mapMarker?.isDraggable = true
            map.add(mapObject: self.mapMarker!)
        } else {
            let geoCenterLocation = MapManager.defaultGeoCenter
            let geoCenter = NMAGeoCoordinates(
                latitude: geoCenterLocation.latitude, longitude: geoCenterLocation.longitude
            )
            map.set(geoCenter: geoCenter, zoomLevel: zoomedInLevel, animation: .linear)
            
        }
    }
    
    private func updateResults() {
        resultsTableView.reloadData()
        resultsTableView.isHidden = model.searchResults.isEmpty || !searchTextField.isEditing
    }
    
    private func updateSaveButton(animated: Bool = false) {
        UIView.animate(withDuration: animated ? 0.3 : 0) {
            self.saveButton.alpha = self.model.canSave ? 1 : 0
        }
    }
    
    private var delayedSearchTimer: Timer?
    private func searchDelayed(_ query: String) {
        delayedSearchTimer?.invalidate()
        delayedSearchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { [weak self] timer in
            guard let self = self else { return }
            self.model.search(query: query)
                .then { [weak self] in
                    self?.updateResults()
                }
                .catch { error in
                    LogError(error)
                }
        })
    }

    @IBAction func handleSaveAction(_ sender: Any) {
        
    }
    
    @IBAction func handleLocationAction(_ sender: Any) {
        // TODO: implement proper localization
//        MapManager.shared.getPermissions()
//            .then {
//                MapManager.shared.askForLocation()
//                    .then { LogInfo("found location: \($0)") }
//                    .catch {LogError("can't get location: \($0)") }
//            }
//            .catch { LogError("can't get permission: \($0)") }
    }
}

extension SearchAddressViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        searchDelayed(text)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateResults()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateResults()
        return true
    }
}

extension SearchAddressViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchTableCell.cellIdentifier,
            for: indexPath
        ) as! SearchTableCell
        
        let model = self.model.searchResults[indexPath.row]
        cell.nameLabel.text = model.address
        return cell
    }
    
}

extension SearchAddressViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView(frame: .zero)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        .searchCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTextField.resignFirstResponder()
        model.selectedLocation = model.searchResults[indexPath.row]
        updateResults()
        updateMap()
        updateSaveButton()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
