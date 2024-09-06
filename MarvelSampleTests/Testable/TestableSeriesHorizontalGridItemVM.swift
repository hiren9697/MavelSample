//
//  TestableSeriesHorizontalGridItemVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 06/09/24.
//

import Foundation
@testable import MarvelSample
/// Child class of SeriesHorizontalGridItemVM, Used to inject dummy model id and MockAPIService
/// Used in:
/// 1. SeriesHorizontalGridItemVMTests
final class TestableSeriesHorizontalGridItemVM: SeriesHorizontalGridItemVM {
    /// Injected MockAPIService to prevent API call in tests
    init() {
        super.init(modelID: "testableModelID",
                   service: MockAPIService(requestGenerator: TestableAPIRequestGenerator()))
    }
}
