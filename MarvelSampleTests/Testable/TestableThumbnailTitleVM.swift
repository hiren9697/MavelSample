//
//  TestableThumbnailTitleVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 14/08/24.
//

import Foundation
import Combine
@testable import MarvelSample

/// Dummy class used to fill the space
/// Used in:
/// 1. TestableHorizontalThumbnailTitleGridVM
/// 2. ThumbnailTitleCCTests
/// 3. ThumbnailTitleCCSnapshotTests
/// 4. HorizontalThumbnailTitleGridViewTests
/// 5. HorizontalThumbnailTitleGridViewSnapshotTests
class TestableThumbnailTitleVM: ThumbnailTitleItemViewModel {
    let title: String?
    let thumbnailURL: URL?
    var dataFetchState: CurrentValueSubject<MarvelSample.ListItemLoadingState, Never>?
    let errorVM: ErrorVM?
    
    init(title: String,
         thumbnailURL: URL?,
         dataFetchState: CurrentValueSubject<MarvelSample.ListItemLoadingState, Never>?,
         errorVM: ErrorVM?) {
        self.title = title
        self.thumbnailURL = thumbnailURL
        self.dataFetchState = dataFetchState
        self.errorVM = errorVM
    }
    
    func fetchData() {
    }
}

extension TestableThumbnailTitleVM: Equatable {
    static func == (lhs: TestableThumbnailTitleVM, rhs: TestableThumbnailTitleVM) -> Bool {
        lhs.title == rhs.title &&
        lhs.thumbnailURL == rhs.thumbnailURL &&
        lhs.errorVM == rhs.errorVM
    }
    
    
}
