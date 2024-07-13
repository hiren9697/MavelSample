//
//  ParentTC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import UIKit

class ParentTC: UITableViewCell {
    
    static var name: String {
        String(describing: self)
    }
    
    override var reuseIdentifier: String? {
        Self.name
    }
    
    static var nib: UINib {
        UINib(nibName: name, bundle: nil)
    }
}

