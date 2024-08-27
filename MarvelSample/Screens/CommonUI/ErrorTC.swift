//
//  ErrorTC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 31/07/24.
//

import UIKit

// MARK: - CC
/// TableView cell that displayed when error is encountered from web service
class ErrorTC: ParentTC {
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "error")!
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInitialUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Helper
extension ErrorTC {
    private func setupInitialUI() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        iconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        /// If I don't decrease priority of title label top constraint,
        let titleLabelTopConstraint = titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 30)
        titleLabelTopConstraint.priority = UILayoutPriority(999)
        titleLabelTopConstraint.isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: iconImageView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: iconImageView.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
}

