//
//  ErrorCC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 16/07/24.
//

import UIKit

// MARK: - CC
class ErrorCC: ParentCC {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "error")!
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.textColor = UIColor.gray
        label.numberOfLines = 2
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupInitialUI()
    }
}

// MARK: - UI Helper
extension ErrorCC {
    
    private func setupInitialUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
}

