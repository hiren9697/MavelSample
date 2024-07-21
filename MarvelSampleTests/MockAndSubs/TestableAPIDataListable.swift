//
//  TestableAPIDataListable.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 20/07/24.
//

import Foundation
import Combine
@testable import MarvelSample

class TestableAPIDataListable: APIDataListable {
    var fetchState: CurrentValueSubject<DataFetchState, Never> = CurrentValueSubject(.idle)
    var data: Array<TestableData> = []
    var listItems: CurrentValueSubject<Array<TestableDataItemVM>, Never> = CurrentValueSubject([])
    
    func fetchInitialData() {}
    func reloadData() {}
    func itemVM(for: Int) -> TestableDataItemVM {
        TestableDataItemVM(text: "Hello")
    }
}
