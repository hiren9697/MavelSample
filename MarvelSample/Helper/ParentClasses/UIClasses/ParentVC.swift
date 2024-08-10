//
//  ParentVC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 14/07/24.
//

import UIKit

/// Base view controller with loader functionality
class ParentVC: UIViewController {
    let loader: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = AppColors.red
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    let loaderContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = false
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5
        view.layer.shadowColor = UIColor.lightGray.cgColor
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupInitialUI()
    }
    
    // MARK: - UI Helper
    /// Adds UI components to View and setup constraints
    func setupConstraints() {
        view.addSubview(loaderContainer)
        loaderContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loaderContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loaderContainer.widthAnchor.constraint(equalToConstant: 80).isActive = true
        loaderContainer.heightAnchor.constraint(equalToConstant: 80).isActive = true
        loaderContainer.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: loaderContainer.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: loaderContainer.centerYAnchor).isActive = true
    }
    
    /// Configure UI components
    func setupInitialUI() {
        view.backgroundColor = .white
        loaderContainer.isHidden = true
        loader.stopAnimating()
    }
    
    func showLoader() {
        loader.startAnimating()
        loaderContainer.isHidden = false
    }
    
    func hideLoader() {
        loader.stopAnimating()
        loaderContainer.isHidden = true
    }
}
