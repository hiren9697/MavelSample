//
//  EventTC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 31/07/24.
//

import UIKit
import Kingfisher

class EventItemTC: ParentTC {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        label.textColor = .darkGray
        label.numberOfLines = 2
        return label
    }()
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        return stackView
    }()
    
    var viewModel: EventItemVM?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUIInitial()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // setupUIInitial()
    }
    
    private func setupUIInitial() {
        // ContainerView
        contentView.addSubview(containerView)
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        // ImageView
        containerView.addSubview(iconImageView)
        iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        iconImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        /// Note: If I don't decrese priority of imageViewHeight constraint, Auto layout system breaks this constraint
        /// This is strange and I think should not happen, So I have to decrease priority of imageViewHeight constraint, eventhough I am not able to understand why
        let imageViewHeightConstraint = iconImageView.heightAnchor.constraint(equalToConstant: 100)
        imageViewHeightConstraint.priority = UILayoutPriority(999)
        imageViewHeightConstraint.isActive = true
        iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor, multiplier: 0.8).isActive = true
        // LabelsStackView
        containerView.addSubview(labelsStackView)
        labelsStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8).isActive = true
        labelsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
        labelsStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        labelsStackView.topAnchor.constraint(greaterThanOrEqualTo: iconImageView.topAnchor).isActive = true
        labelsStackView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -10).isActive = true
    }
    
    internal func updateUI(viewModel: EventItemVM) {
        iconImageView.kf.setImage(with: viewModel.thumbnailURL)
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.descriptionText
    }
}
