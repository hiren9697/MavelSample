//
//  TestableHorizontalThumbnailTitleGridVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 10/08/24.
//

import Foundation
@testable import MarvelSample
/// Confirms to HorizontalThumbnailTitleGridViewModel, as HorizontalThumbnailTitleGridViewModel can not be instantiated, used to fill the space
/// Used in:
/// 1. HorizontalThumbnailTitleGridViewTests
/// 2. HorizontalThumbnailTitleGridSnapshotTests
class TestableHorizontalThumbnailTitleGridVM: HorizontalThumbnailTitleGridViewModel {
    let title: String
    let emptyDataTitle: String
    var data: Array<TestableThumbnailTitleVM>
    
    init(title: String,
         emptyDataTitle: String,
         data: Array<TestableThumbnailTitleVM>) {
        self.title = title
        self.emptyDataTitle = emptyDataTitle
        self.data = data
    }
}
