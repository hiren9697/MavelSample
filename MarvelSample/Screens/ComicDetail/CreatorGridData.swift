//
//  CreatorGridData.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 10/08/24.
//

import Foundation

final class CreatorGridVM: HorizontalThumbnailTitleGridViewModel {
    let title: String
    let emptyDataTitle: String
    var data: [CDCreatorItemVM]
    
    init(title: String = "Creators",
         emptyDataTitle: String = "Couln't found any creator",
         data: [CDCreatorItemVM]) {
        self.title = title
        self.emptyDataTitle = emptyDataTitle
        self.data = data
    }
}

extension CreatorGridVM: Equatable {
    static func == (lhs: CreatorGridVM, rhs: CreatorGridVM) -> Bool {
        lhs.title == rhs.title &&
        lhs.emptyDataTitle == rhs.emptyDataTitle &&
        lhs.data == rhs.data
    }
}
