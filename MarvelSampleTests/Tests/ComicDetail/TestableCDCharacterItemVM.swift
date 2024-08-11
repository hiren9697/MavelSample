//
//  TestableCDCharacterItemVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 11/08/24.
//

import Foundation
@testable import MarvelSample

class TestableCDCharacterItemVM: CDCharacterItemVM {
    
    init() {
        super.init(modelID: "testableModelID",
                   service: MockAPIService(requestGenerator: TestableAPIRequestGenerator()))
    }
}
