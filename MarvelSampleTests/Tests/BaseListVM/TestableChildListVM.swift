//
//  TestableBaseListVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 25/07/24.
//

import Foundation
@testable import MarvelSample

/// Sub-class of BaseLisVM, Written to fill generics, as BaseListVM is designed as abstract class
class TestableChildListVM: BaseListVM<TestableData,
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
    
    override func parseData(json: Any) {
        guard let results = JSONParser().parseListJSON(json) else {
            return
        }
        var newData: [TestableData] = []
        var newDataItems: [TestableDataItemVM] = []
        for item in results {
            let object = TestableData(dictionary: item)
            newData.append(object)
            newDataItems.append(TestableDataItemVM(text: object.text))
        }
        self.data.append(contentsOf: newData)
        listItems.value.append(contentsOf: newDataItems)
    }
}
