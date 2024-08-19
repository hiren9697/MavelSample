//
//  ErrorView.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 10/08/24.
//

import UIKit

/// View that displayed when received error from web service
/// Used in ThumbnailTitleCC with lazy loading
class ErrorView: UIView {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .center
        label.textColor = UIColor.lightGray
        label.numberOfLines = 2
        return label
    }()
    
    /// Supports lazy loading of view model, Because this view is displayed in many cells, where view model is not available at the time of initialization
    var viewModel: ErrorVM?
    
    init(viewModel: ErrorVM?) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupConstraints()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helper
extension ErrorView {
    private func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        // StackView
        self.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        // ImageView
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        stackView.addArrangedSubview(imageView)
        // Title Label
        stackView.addArrangedSubview(titleLabel)
    }
    
    func updateViewModel(_ viewModel: ErrorVM?) {
        self.viewModel = viewModel
        guard viewModel != nil else {
            return
        }
        setupUI()
    }
    
    private func setupUI() {
        guard let viewModel = viewModel else {
            return
        }
        imageView.image = UIImage(named: viewModel.imageName)
        titleLabel.text = viewModel.title
    }
}
