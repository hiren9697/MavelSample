//
//  CRDComicsGridVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 02/09/24.
//

import Foundation
/// ViewModel for characters list displayed in comic detail screen(ComicDetailVC)
final class CRDComicsGridVM: HorizontalThumbnailTitleGridViewModel {
    let title: String
    let emptyDataTitle: String
    var data: [CRDComicItemVM]
    
    init(title: String = "Comics",
         emptyDataTitle: String = "Couln't found any Comic",
         data: [CRDComicItemVM]) {
        self.title = title
        self.emptyDataTitle = emptyDataTitle
        self.data = data
    }
}

extension CRDComicsGridVM: Equatable {
    static func == (lhs: CRDComicsGridVM, rhs: CRDComicsGridVM) -> Bool {
        lhs.title == rhs.title &&
        lhs.emptyDataTitle == rhs.emptyDataTitle &&
        lhs.data == rhs.data
    }
}
