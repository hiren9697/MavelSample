//
//  TestableComicsVC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 23/07/24.
//

import UIKit
@testable import MarvelSample

/// A subclass of ComicsVC written to prevent API call automatically when view loads, and prevent image loading from web
/// This class is used in unit tests whereever a ComicsVC expected
/// If we uses actual ComicsVC, actual API call will be called every-time a object of ComicsVC created and image loading will be attempted on updating collectionView cell's data
class TestableComicsVC: ComicsVC {
    override func fetchInitialData() {
        // Do nothing
    }
    
    // MARK: - Datasource methods
    override func registerCollectionViewDataCell() {
        collectionView.register(TestableThumbnailTitleCC<ComicItemVM>.self,
                                forCellWithReuseIdentifier: TestableThumbnailTitleCC<ComicItemVM>.name)
    }
    
    override func dequeueDataCell(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestableThumbnailTitleCC<ComicItemVM>.name,
                                           for: indexPath) as! TestableThumbnailTitleCC<ComicItemVM>
        cell.update(viewModel: viewModel.itemVM(for: indexPath.row))
        return cell
    }
}
