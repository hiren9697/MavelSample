//
//  HorizontalGridData.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 10/08/24.
//

import Foundation
import Combine

/// Data needed to display horizontal grid,
/// Horizontal grids are displayed in detail screens
protocol HorizontalThumbnailTitleGridViewModelProtocol {
    associatedtype ItemViewModel: ThumbnailTitleItemViewModel
    var title: String { get }
    var emptyDataTitle: String { get }
    var data: Array<ItemViewModel> { get set }
}


