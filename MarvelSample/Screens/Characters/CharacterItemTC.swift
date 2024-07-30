//
//  CharacterItemTC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 29/07/24.
//

import UIKit

class CharacterItemCC: ParentCC {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
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
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 2
        return label
    }()
    
    var viewModel: CharacterItemVM?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUIInitial()
    }
}

// MARK: - UI Helper
extension CharacterItemCC {
    
    private func setupUIInitial() {
        contentView.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        containerView.addSubview(imageView)
        containerView.addSubview(nameLabel)
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
    }
    
    func updateUI(viewModel: CharacterItemVM) {
        self.viewModel = viewModel
        nameLabel.text = viewModel.name
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
}
