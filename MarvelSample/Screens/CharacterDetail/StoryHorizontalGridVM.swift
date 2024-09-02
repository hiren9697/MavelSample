//
//  StoryHorizontalGridVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 02/09/24.
//

import Foundation

/// ViewModel for horizontal grid of series
final class StoryHorizontalGridVM: HorizontalThumbnailTitleGridViewModel {
    let title: String
    let emptyDataTitle: String
    var data: [StoryHorizontalGridItemVM]
    
    init(title: String = "Stories",
         emptyDataTitle: String = "Couln't found any Story",
         data: [StoryHorizontalGridItemVM]) {
        self.title = title
        self.emptyDataTitle = emptyDataTitle
        self.data = data
    }
}

extension StoryHorizontalGridVM: Equatable {
    static func == (lhs: StoryHorizontalGridVM, rhs: StoryHorizontalGridVM) -> Bool {
        lhs.title == rhs.title &&
        lhs.emptyDataTitle == rhs.emptyDataTitle &&
        lhs.data == rhs.data
    }
}
