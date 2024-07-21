//
//  TestableCollectionCell.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 20/07/24.
//

import UIKit
@testable import MarvelSample


class TestableCollectionCell: ParentCC {
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(textLabel)
        textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                           constant: 20).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                            constant: -20).isActive = true
        textLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                       constant: 10).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: -10).isActive = true
    }
}
