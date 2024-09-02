//
//  CRDComicsGridVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 02/09/24.
//

import Foundation
/// ViewModel for characters list displayed in comic detail screen(ComicDetailVC)
final class ComicHorizontalGridVM: HorizontalThumbnailTitleGridViewModel {
    let title: String
    let emptyDataTitle: String
    var data: [ComicHorizontalGridItemVM]
    
    init(title: String = "Comics",
         emptyDataTitle: String = "Couln't found any Comic",
         data: [ComicHorizontalGridItemVM]) {
        self.title = title
        self.emptyDataTitle = emptyDataTitle
        self.data = data
    }
}

extension ComicHorizontalGridVM: Equatable {
    static func == (lhs: ComicHorizontalGridVM, rhs: ComicHorizontalGridVM) -> Bool {
        lhs.title == rhs.title &&
        lhs.emptyDataTitle == rhs.emptyDataTitle &&
        lhs.data == rhs.data
    }
}
