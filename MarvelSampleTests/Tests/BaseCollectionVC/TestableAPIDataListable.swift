//
//  TestableAPIDataListable.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 20/07/24.
//

import Foundation
import Combine
@testable import MarvelSample

/// A dummy class used to fill space in TestableBaseCollectionVC and TestableBaseTableVC
/// This class just provides must required variables and method
/// Doesn't provide actual behaviour like fetch data and load next page when view controller accesses last list item view model
/// Test classes have to manually change binding and other variables to perform tests
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
