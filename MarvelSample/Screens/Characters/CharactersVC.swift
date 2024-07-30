//
//  CharactersVC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 12/07/24.
//

import UIKit

// MARK: - VC
class CharactersVC: BaseCollectionVC<Character,
                    CharacterItemVM,
                    CharactersVM> {

    // MARK: - Variables
    let itemSpace: CGFloat = 10
    let lineSpace: CGFloat = 10
    let padding: CGFloat = 20
    lazy var itemSize: CGSize = {
        let extraWidth = itemSpace + (padding * 2)
        let remainingWidth = view.bounds.width - extraWidth
        let finalWidth = remainingWidth / 2
        let height = finalWidth * 1.3
        return CGSize(width: finalWidth, height: height)
    }()
    
    // MARK: - Cell methods
    override func registerCollectionViewDataCell() {
        collectionView.register(CharacterItemCC.self,
                                forCellWithReuseIdentifier: CharacterItemCC.name)
    }
    
    override func dequeueCell(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterItemCC.name,
                                           for: indexPath) as! CharacterItemCC
        cell.updateUI(viewModel: viewModel.itemVM(for: indexPath.row))
        return cell
    }
    
    // MARK: - CollectionView FlowLayout
    override func collectionViewMinimumInterItemSpacingFor(section: Int) -> CGFloat {
        itemSpace
    }
    
    override func collectionViewMinimumLineSpacingFor(section: Int) -> CGFloat {
        lineSpace
    }
    
    override func collectionViewInsetsFor(section: Int) -> UIEdgeInsets {
        UIEdgeInsets.init(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    override func collectionViewSizeForItem(at indexPath: IndexPath) -> CGSize {
        itemSize
    }
}
