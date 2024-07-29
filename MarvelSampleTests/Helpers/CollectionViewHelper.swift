//
//  CollectionViewHelper.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 10/07/24.
//

import UIKit

func numberOfSections(in collectionView: UICollectionView)-> Int? {
    collectionView
        .dataSource?
        .numberOfSections?(in: collectionView)
}

func numberOfRows(in collectionView: UICollectionView,
                  section: Int = 0)-> Int? {
    collectionView
        .dataSource?
        .collectionView(collectionView,
                        numberOfItemsInSection: section)
}

func cellForRow(in collectionView: UICollectionView,
                row: Int,
                section: Int = 0) -> UICollectionViewCell? {
    collectionView
        .dataSource?
        .collectionView(collectionView,
                        cellForItemAt: IndexPath(row: row, section: section))
}

func referenceSizeForFooterView(in collectionView: UICollectionView)-> CGSize? {
    let collectionViewLayout = collectionView.collectionViewLayout
    guard let delegateFlowLayout = collectionView.delegate as? UICollectionViewDelegateFlowLayout else {
        return nil
    }
    let size = delegateFlowLayout.collectionView?(collectionView,
                                                  layout: collectionViewLayout,
                                                  referenceSizeForFooterInSection: 0)
    return size
}

func footer(in collectionView: UICollectionView,
            row: Int = 0,
            section: Int = 0)-> UICollectionReusableView? {
    collectionView
        .dataSource?
        .collectionView?(collectionView,
                         viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter,
                         at: IndexPath(row: row, section: section))
}

func didSelectRow(in collectionView: UICollectionView,
                  row: Int,
                  section: Int = 0) {
    collectionView
        .delegate?
        .collectionView?(collectionView,
                         didSelectItemAt: IndexPath(row: row, section: section))
}

func indexPathsFor(items: [Int],
                   section: Int = 0)-> [IndexPath] {
    return items.map { IndexPath(item: $0, section: section) }
}

