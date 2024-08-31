//
//  TestableCharactersVC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 30/07/24.
//

import UIKit
@testable import MarvelSample

/// A subclass of CharactersVC written to prevent API call automatically when view loads, and prevent image loading from web
/// This class is used in unit tests whereever a CharactersVC expected
/// If we uses actual CharactersVC, actual API call will be called every-time a object of CharactersVC created, and image loading will be attempted on updating collectionView cell's data
/// Used in:
/// 1. TestableFlowManager
/// 2. TabBarTests
/// 3. CharactersVCTests
/// 4. CharactersVCSnapshotTests
class TestableCharactersVC: CharactersVC {
    override func fetchInitialData() {
        // Do nothing
    }
    
    override func registerCollectionViewDataCell() {
        collectionView.register(TestableThumbnailTitleCC<CharacterItemVM>.self,
                                forCellWithReuseIdentifier: TestableThumbnailTitleCC<CharacterItemVM>.name)
    }
    
    override func dequeueDataCell(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestableThumbnailTitleCC<CharacterItemVM>.name,
                                           for: indexPath) as! TestableThumbnailTitleCC<CharacterItemVM>
        cell.update(viewModel: viewModel.itemVM(for: indexPath.row))
        return cell
    }
}

