//
//  TestableCDCreatorItemVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 11/08/24.
//

import XCTest
@testable import MarvelSample

final class TestableCDCreatorItemVM: CDCreatorItemVM {

    /// Injected MockAPIService to prevent API call in tests
    init() {
        super.init(modelID: "testableModelID",
                   service: MockAPIService(requestGenerator: TestableAPIRequestGenerator()))
    }
}
