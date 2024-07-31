//
//  EventTC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 31/07/24.
//

import UIKit

class EventItemTC: ParentTC {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    let iconImageView: UIImageView = {
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
    
    var viewModel: EventItemVM?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUIInitial()
    }
    
    private func setupUIInitial() {
        contentView.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: iconImageView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: iconImageView.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
    }
}
