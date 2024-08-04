//
//  ComicsVC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 12/07/24.
//

import UIKit
import Combine

class ComicsVC: BaseCollectionVC<Comic,
         ComicItemVM,
         ComicsVM> {
    
    // MARK: - Variables
    let itemSpace: CGFloat = 10
    let lineSpace: CGFloat = 10
    let padding: CGFloat = 20
    lazy var itemSize: CGSize = {
        let extraWidth = itemSpace + (padding * 2)
        let remainingWidth = view.bounds.width - extraWidth
        let finalWidth = remainingWidth / 2
        let height = finalWidth * 1.4
        return CGSize(width: finalWidth, height: height)
    }()
    
    // MARK: - Datasource methods
    override func registerCollectionViewDataCell() {
        collectionView.register(ThumbnailTitleCC<ComicItemVM>.self,
                                forCellWithReuseIdentifier: ThumbnailTitleCC<ComicItemVM>.name)
    }
    
    override func dequeueCell(at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ThumbnailTitleCC<ComicItemVM>.name,
                                           for: indexPath) as! ThumbnailTitleCC<ComicItemVM>
        cell.updateUI(viewModel: viewModel.itemVM(for: indexPath.row))
        return cell
    }
    
    // MARK: - Delegate method
    override func collectionViewDidSelect(indexPath: IndexPath) {
        let comicDetailVM = viewModel.getComicDetailVM(for: indexPath.row)
        navigationController?.pushViewController(ComicDetailVC(viewModel: comicDetailVM),
                                                 animated: true)
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
