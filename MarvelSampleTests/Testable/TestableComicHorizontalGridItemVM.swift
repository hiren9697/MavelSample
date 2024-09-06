//
//  TestableComicHorizontalGridItemVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 06/09/24.
//

import Foundation
@testable import MarvelSample
/// Child class of ComicHorizontalGridItemVM, Used to inject dummy model id and MockAPIService
/// Used in:
/// 1. SeriesHorizontalGridItemVMTests
final class TestableComicHorizontalGridItemVM: ComicHorizontalGridItemVM {
    /// Injected MockAPIService to prevent API call in tests
    init() {
        super.init(modelID: "testableModelID",
                   service: MockAPIService(requestGenerator: TestableAPIRequestGenerator()))
    }
}
