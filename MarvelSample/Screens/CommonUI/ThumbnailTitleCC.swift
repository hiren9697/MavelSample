//
//  ThumbnailTitleTC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 04/08/24.
//

import UIKit
import Combine

class ThumbnailTitleCC<ViewModel: ThumbnailTitleData>: ParentCC {
    
    // MARK: - UI Components
    /// Main view child of contentView
    /// Holds all UI components
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    let loader: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        activity.style = .medium
        activity.color = AppColors.red
        return activity
    }()
    /// Holds all the UI components that shows data
    let dataContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Variables
    var viewModel: ViewModel?
    private var bindings = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIInitial()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bindings.removeAll()
    }
}

// MARK: - UI Helper
extension ThumbnailTitleCC {
    
    private func setupUIInitial() {
        // ContainerView
        contentView.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        // DataContainerView
        containerView.addSubview(dataContainerView)
        dataContainerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        dataContainerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        dataContainerView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        dataContainerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        // ImageView
        dataContainerView.addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: dataContainerView.leadingAnchor, constant: 10).isActive = true
        imageView.trailingAnchor.constraint(equalTo: dataContainerView.trailingAnchor, constant: -10).isActive = true
        imageView.topAnchor.constraint(equalTo: dataContainerView.topAnchor, constant: 10).isActive = true
        
        // Title label
        dataContainerView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: dataContainerView.bottomAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        // Loader
        containerView.addSubview(loader)
        loader.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
    
    func update(viewModel: ViewModel) {
        self.viewModel = viewModel
        setupBinding()
        updateUIBasedOnFetchState()
        fetchDataIfRequired()
    }
    
    private func setupBinding() {
        guard let viewModel = viewModel else {
            return
        }
        guard let dataFetchState = viewModel.dataFetchState else {
            return
        }
        dataFetchState
            .sink {[weak self] state in
                self?.updateUIBasedOnFetchState()
            }
            .store(in: &bindings)
    }
    
    private func updateUIBasedOnFetchState() {
        guard let viewModel = viewModel else {
            return
        }
        // Helper methods
        func showLoaderAndHideUIComponents() {
            loader.startAnimating()
            dataContainerView.isHidden = true
        }
        func hideLoaderAndShowUIComponents() {
            loader.stopAnimating()
            dataContainerView.isHidden = false
        }
        func hideEverything() {
            loader.stopAnimating()
            dataContainerView.isHidden = true
        }
        func setData() {
            titleLabel.text = viewModel.title
            imageView.contentMode = .scaleAspectFit
            imageView.kf.setImage(with: viewModel.thumbnailURL,
                                  placeholder: UIImage(systemName: "photo"),
                                  completionHandler: {[weak self] result in
                switch result {
                case .success(_):
                    self?.imageView.contentMode = .scaleAspectFill
                case .failure(_):
                    break
                }
            })
        }
        // Logic
        self.viewModel = viewModel
        guard let loadingState = viewModel.dataFetchState else {
            setData()
            hideLoaderAndShowUIComponents()
            return
        }
        switch loadingState.value {
        case .notStarted:
            hideEverything()
        case .loading:
            showLoaderAndHideUIComponents()
        case .loaded:
            setData()
            hideLoaderAndShowUIComponents()
        case .failed:
            break
        }
    }
    
    private func fetchDataIfRequired() {
        guard let viewModel = viewModel else {
            return
        }
        guard let dataFetchState = viewModel.dataFetchState else {
            return
        }
        if dataFetchState.value == .notStarted {
            viewModel.fetchData()
        }
    }
}
