//
//  TestableTableCell.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 02/08/24.
//

import UIKit
@testable import MarvelSample

/// A dummy class of collection view cell used to fill space in TestableBaseCollectionVC
class TestableTableCell: ParentTC {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                           constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                            constant: -20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                       constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                          constant: -10).isActive = true
    }
}
