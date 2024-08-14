//
//  ParentCC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import UIKit

class ParentCC: UICollectionViewCell {
    
    override var reuseIdentifier: String? {
        Self.name
    }
    
    static var nib: UINib {
        UINib(nibName: name, bundle: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
