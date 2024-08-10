//
//  ThumbnailTitleItemViewModelData.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 10/08/24.
//

import Foundation

/// Data need to be provided to ThumbnailTitleCC
protocol ThumbnailTitleItemViewModelData {
    var dataFetchState: CurrentValueSubject<ListItemLoadingState, Never>? { get set }
    var title: String? { get }
    var thumbnailURL: URL? { get }
    
    func fetchData()
}
