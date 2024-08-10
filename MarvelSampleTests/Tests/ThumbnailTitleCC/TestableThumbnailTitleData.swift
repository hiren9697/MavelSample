//
//  TestableThumbnailTitleData.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 04/08/24.
//

import Foundation
import Combine
@testable import MarvelSample

class TestableThumbnailTitleVM: ThumbnailTitleItemViewModel {
    var dataFetchState: CurrentValueSubject<MarvelSample.ListItemLoadingState, Never>?
    let title: String?
    let thumbnailURL: URL?
    
    init(title: String,
         thumbnailURL: URL?,
         dataFetchState: CurrentValueSubject<MarvelSample.ListItemLoadingState, Never>?) {
        self.title = title
        self.thumbnailURL = thumbnailURL
        self.dataFetchState = dataFetchState
    }
    
    func fetchData() {
    }
}
