//
//  SeriesGridVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 02/09/24.
//

import Foundation

/// ViewModel for horizontal grid of series
final class SeriesHorizontalGridVM: HorizontalThumbnailTitleGridViewModel {
    let title: String
    let emptyDataTitle: String
    var data: [SeriesHorizontalGridItemVM]
    
    init(title: String = "Series",
         emptyDataTitle: String = "Couln't found any Series",
         data: [SeriesHorizontalGridItemVM]) {
        self.title = title
        self.emptyDataTitle = emptyDataTitle
        self.data = data
    }
}

extension SeriesHorizontalGridVM: Equatable {
    static func == (lhs: SeriesHorizontalGridVM, rhs: SeriesHorizontalGridVM) -> Bool {
        lhs.title == rhs.title &&
        lhs.emptyDataTitle == rhs.emptyDataTitle &&
        lhs.data == rhs.data
    }
}
