//
//  CDCharacterItemCC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 04/08/24.
//

import UIKit
import Kingfisher

class CDCharacterItemCC: ParentCC {

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
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 2
        return label
    }()
    
    // var viewModel: ComicItemVM?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUIInitial()
    }
}

// MARK: - UI Helper
extension CDCharacterItemCC {
    
    private func setupUIInitial() {
        contentView.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        containerView.addSubview(imageView)
        containerView.addSubview(titleLabel)
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
    }
    
//    func updateUI(viewModel: ComicItemVM) {
//        self.viewModel = viewModel
//        titleLabel.text = viewModel.title
//        imageView.contentMode = .scaleAspectFit
//        imageView.kf.setImage(with: viewModel.thumbnailURL,
//                              placeholder: UIImage(systemName: "photo"),
//                              completionHandler: {[weak self] result in
//            switch result {
//            case .success(_):
//                self?.imageView.contentMode = .scaleAspectFill
//            case .failure(_):
//                break
//            }
//        })
//    }
}

