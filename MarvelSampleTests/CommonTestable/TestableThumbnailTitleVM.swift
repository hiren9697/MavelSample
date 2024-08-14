//
//  TestableThumbnailTitleVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 14/08/24.
//

import Foundation
import Combine
@testable import MarvelSample

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
