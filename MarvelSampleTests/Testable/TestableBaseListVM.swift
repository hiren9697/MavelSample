//
//  TestableBaseListVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 25/07/24.
//

import Foundation
@testable import MarvelSample

/// Sub-class of BaseLisVM, Written to fill generics
class TestableBaseListVM: BaseListVM<TestableData,
                          TestableDataItemVM> {
    
    init(endpoint: String,
         emptyDataTitle: String,
         errorTitle: String,
         service: MockAPIService) {
        super.init(endPoint: endpoint,
                   service: service,
                   emptyDataTitle: emptyDataTitle,
                   errorTitle: errorTitle)
    }
}
