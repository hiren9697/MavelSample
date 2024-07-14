//
//  TestableCollectionView.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 13/07/24.
//

import UIKit

class TestableCollectionView: UICollectionView {
    
    var testableScrolledIndexPath: IndexPath?
    
    override func scrollToItem(at indexPath: IndexPath,
                               at scrollPosition: UICollectionView.ScrollPosition,
                               animated: Bool) {
        testableScrolledIndexPath = indexPath
    }
}
