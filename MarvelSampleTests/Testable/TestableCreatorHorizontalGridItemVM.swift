//
//  TestableCDCreatorItemVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 11/08/24.
//

import XCTest
@testable import MarvelSample

/// Child class of CreatorHorizontalGridItemVM, Used to inject dummy model id and MockAPIService
/// Used in:
/// 1. CreatorHorizontalGridItemVMTests
final class TestableCreatorHorizontalGridItemVM: CreatorHorizontalGridItemVM {
    /// Injected MockAPIService to prevent API call in tests
    init() {
        super.init(modelID: "testableModelID",
                   service: MockAPIService(requestGenerator: TestableAPIRequestGenerator()))
    }
}
