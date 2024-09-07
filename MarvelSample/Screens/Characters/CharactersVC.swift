//
//  CharactersVC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 12/07/24.
//

import UIKit

// MARK: - VC
/// ViewControlelr for characters list screen
class CharactersVC: BaseCollectionVC<CharactersVM> {
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
        collectionView.register(ThumbnailTitleCC<CharacterItemVM>.self,
                                forCellWithReuseIdentifier: ThumbnailTitleCC<CharacterItemVM>.name)
    }
    
    override func dequeueDataCell(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailTitleCC<CharacterItemVM>.name,
                                           for: indexPath) as! ThumbnailTitleCC<CharacterItemVM>
        cell.update(viewModel: viewModel.itemVM(for: indexPath.row))
        return cell
    }
    
    override func collectionViewDidSelectDataCell(indexPath: IndexPath) {
        let character = viewModel.data[indexPath.row]
        let characterDetailVC = CharacterDetailVC(viewModel: CharacterDetailVM(character: character))
        navigationController?.pushViewController(characterDetailVC, animated: true)
    }
    
    // MARK: - CollectionView FlowLayout
    override func collectionViewMinimumInterItemSpacingFor(section: Int) -> CGFloat {
        itemSpace
    }
    
    override func collectionViewMinimumLineSpacingFor(section: Int) -> CGFloat {
        lineSpace
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets.init(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    override func collectionViewSizeForItem(at indexPath: IndexPath) -> CGSize {
        itemSize
    }
}
