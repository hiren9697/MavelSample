//
//  ThumbnailTitleData.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 04/08/24.
//

import UIKit

enum ListItemLoadingState {
    case loading
    case loaded
    case failed
}

/// Data need to be provided to ThumbnailTitleCC
protocol ThumbnailTitleData {
    var loadingState: ListItemLoadingState? { get set }
    var title: String { get }
    var thumbnailURL: URL? { get }
}
