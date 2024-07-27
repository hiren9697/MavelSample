//
//  TestableCollectionView.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 13/07/24.
//

import UIKit

/// I wrote this class, because in testing I was not getting accurate value for visibleCells
/// 'testableScrolledIndexPath' contains last indexPath on which scrollToItem was called and I use it to test
/// Used in TestableWalkthroughVC
class TestableCollectionView: UICollectionView {
    
    var testableScrolledIndexPath: IndexPath?
    
    override func scrollToItem(at indexPath: IndexPath,
                               at scrollPosition: UICollectionView.ScrollPosition,
                               animated: Bool) {
        testableScrolledIndexPath = indexPath
    }
}
