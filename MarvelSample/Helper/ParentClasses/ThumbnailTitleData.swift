//
//  ThumbnailTitleData.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 04/08/24.
//

import UIKit
import Combine

enum ListItemLoadingState {
    case notStarted
    case loading
    case loaded
    case failed
}

/// Data need to be provided to ThumbnailTitleCC
protocol ThumbnailTitleData {
    var dataFetchState: CurrentValueSubject<ListItemLoadingState, Never>? { get set }
    var title: String { get }
    var thumbnailURL: URL? { get }
    
    func fetchData()
}
