//
//  CollectionViewHelper.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 10/07/24.
//

import UIKit

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

