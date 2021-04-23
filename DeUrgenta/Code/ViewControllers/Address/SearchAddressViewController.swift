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
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var resultsTableView: UITableView!
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveSpinner: UIActivityIndicatorView!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var locationSpinner: UIActivityIndicatorView!
    
    private var map: NMAMapView!
    private var mapMarker: NMAMapMarker?
    private let zoomedOutLevel: Float = 8
    private let zoomedInLevel: Float = 20
    
    private let addressSearchController = UISearchController(searchResultsController: nil)
    
    private var isLocating: Bool = false {
        didSet {
            locationButton.isEnabled = !isLocating
            isLocating ? locationSpinner.startAnimating() : locationSpinner.stopAnimating()
        }
    }
    
    private var isLoading: Bool = false {
        didSet {
            saveButton.isEnabled = !isLoading
            isLoading
                ? saveSpinner.startAnimating()
                : saveSpinner.stopAnimating()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDependencies()
        setupTableView()
        title = model.screenTitle
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
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleLocationUpdate),
            name: .NMAPositioningManagerDidUpdatePosition,
            object: NMAPositioningManager.sharedInstance())
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
        resultsTableView.isHidden = model.searchResults.isEmpty || !searchBar.isFirstResponder
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
        guard !MapManager.shared.isLocationAccessDenied else {
            LogError("location access denied.")
            return
        }
        
        let didStart = NMAPositioningManager.sharedInstance().startPositioning()
        LogDebug("did start positioning? \(didStart)")
        
        if didStart {
            isLocating = true
        }
    }
    
    @objc
    private func handleLocationUpdate() {
        let position = NMAPositioningManager.sharedInstance().rawPosition
        guard let coordinates = position?.coordinates else { return }
        let c2d = CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
        LogDebug("found coordinate: \(c2d)")
        MapManager.shared.reverseGeocode(c2d)
            .then { [weak self] location in
                self?.model.selectedLocation = location
                self?.isLocating = false
                self?.updateMap()
                self?.updateSaveButton()
                self?.searchBar.text = self?.model.userAddress
                LogDebug("Reversed geocode of location: \(location)")
                NMAPositioningManager.sharedInstance().stopPositioning()
            }
            .catch { LogError("Could not reverse geocode: \($0)") }
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
        searchBar.resignFirstResponder()
        model.selectedLocation = model.searchResults[indexPath.row]
        updateResults()
        updateMap()
        updateSaveButton()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

