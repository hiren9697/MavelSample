//
//  TestableCDCharacterItemVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 11/08/24.
//

import Foundation
@testable import MarvelSample

/// Child class of CharacterHorizontalGridItemVM, used to inject dummy model id and MockAPIService
/// Used in:
/// 1. CharacterHorizontalGridItemVMTests
class TestableCharacterHorizontalGridItemVM: CharacterHorizontalGridItemVM {
    /// Injected MockAPIService to prevent API call in tests
    init() {
        super.init(modelID: "testableModelID",
                   service: MockAPIService(requestGenerator: TestableAPIRequestGenerator()))
    }
}
