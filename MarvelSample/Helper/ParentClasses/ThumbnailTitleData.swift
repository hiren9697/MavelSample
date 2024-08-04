//
//  ThumbnailTitleData.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 04/08/24.
//

import UIKit

/// Data need to be provided to ThumbnailTitleCC
protocol ThumbnailTitleData {
    var title: String { get }
    var thumbnailURL: URL? { get }
}
