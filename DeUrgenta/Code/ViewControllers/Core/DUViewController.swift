//
//  DUViewController.swift
//  DeUrgenta
//
//  Created by Cristi Habliuc on 01.04.2021.
//

import UIKit
import SnapKit

/// Base class for screen view controllers
class DUViewController: UIViewController{
    var isFullscreenSpinnerVisible = false {
        didSet {
            guard isFullscreenSpinnerVisible != oldValue else { return }
            updateFullScreenSpinnerVisibility()
        }
    }
    
    private var fullScreenSpinnerContainer: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.removeBackTitle()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AnalyticsManager.shared.log(.screenVisited(name: String(describing: self)))
    }
    
    private func updateFullScreenSpinnerVisibility() {
        if !isFullscreenSpinnerVisible {
            fullScreenSpinnerContainer?.alpha = 0
            fullScreenSpinnerContainer?.removeFromSuperview()
            fullScreenSpinnerContainer = nil
        } else {
            fullScreenSpinnerContainer = UIView(frame: .zero)
            fullScreenSpinnerContainer?.backgroundColor = .fullScreenLoadingOverlay
            let spinner = DUSpinner(frame: .zero)
            spinner.tintColor = .mainAccent
            fullScreenSpinnerContainer?.addSubview(spinner)
            view.addSubview(fullScreenSpinnerContainer!)
            fullScreenSpinnerContainer?.snp.makeConstraints{ make in
                make.edges.equalTo(view)
            }
            spinner.snp.makeConstraints { make in
                make.center.equalTo(fullScreenSpinnerContainer!)
            }
            spinner.isAnimating = true
        }
    }
    
    func showAlert(withTitle title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
