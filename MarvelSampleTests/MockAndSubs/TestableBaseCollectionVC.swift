//
//  TestableBaseCollectionVC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 20/07/24.
//

import UIKit
import Combine
@testable import MarvelSample

class TestableChildCollectionVC: BaseCollectionVC<TestableData,
                                 TestableDataItemVM,
                                 TestableAPIDataListable> {
    // MARK: - Closure Variables for tests
    var refreshHandler: (()-> Void)?
    
    // MARK: - Overridden method
    override func fetchInitialData() {
        // Do nothing
    }
    
    // MARK: - Cell methods
    override func registerCollectionViewDataCell() {
        collectionView.register(TestableCollectionCell.self,
                                forCellWithReuseIdentifier: TestableCollectionCell.name)
    }
    
    override func dequeueCell(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestableCollectionCell.name,
                                                      for: indexPath) as! TestableCollectionCell
        cell.textLabel.text = viewModel.itemVM(for: indexPath.row).text
        return cell
    }
    
    // MARK: - CollectionView FlowLayout
    override func collectionViewMinimumInterItemSpacingFor(section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    override func collectionViewMinimumLineSpacingFor(section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
    
    override func collectionViewInsetsFor(section: Int) -> UIEdgeInsets {
        UIEdgeInsets.zero
    }
    
    override func collectionViewSizeForItem(at indexPath: IndexPath) -> CGSize {
        CGSize(width: 100, height: 100)
    }
    
    // MARK: - Overidden methods for tests
    @objc override func handleRefresh() {
        refreshHandler?()
    }
}
