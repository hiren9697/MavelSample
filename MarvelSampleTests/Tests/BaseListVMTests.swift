//
//  BaseListVMTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 25/07/24.
//

import XCTest
@testable import MarvelSample

final class BaseListVMTests: XCTestCase {

    var sut: TestableBaseListVM!
    var service: MockAPIService!
    var apiRequestGenerator: TestableAPIRequestGenerator!
    lazy var timestampDate: Date = Date()
    
    override func setUp() {
        super.setUp()
        apiRequestGenerator = TestableAPIRequestGenerator()
        service = MockAPIService(requestGenerator: apiRequestGenerator)
        sut = TestableBaseListVM(endpoint: APIEndpoints.comics.rawValue,
                                 emptyDataTitle: "Test empty data title",
                                 errorTitle: "Test error title",
                                 service: service)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
}

// MARK: - Test Cases
extension BaseListVMTests {
    
    func test_listItem_returnsCorrectListItemVM() {
        addListItemViewModels()
        let zerothVM = sut.itemVM(for: 0)
        XCTAssertEqual(zerothVM.text, "Zeroth")
        let firstVM = sut.itemVM(for: 1)
        XCTAssertEqual(firstVM.text, "First")
        let lastVM = sut.itemVM(for: 6)
        XCTAssertEqual(lastVM.text, "Sixth")
    }
}

// MARK: - API calling function test
extension BaseListVMTests {
    
    func test_fetchInitialData_makesAPIRequestOneTime() throws {
        let request = try service
            .requestGenerator
            .generateRequestWithHash(requestType: RequestType.get,
                                     relativePath: APIEndpoints.comics.rawValue,
                                     queryParameters: sut.getQueryParametersToFetchData(),
                                     timestampDate: timestampDate)
        sut.fetchInitialData()
        service
            .verifyDataTask(with: request,
                            file: #file,
                            line: #line)
    }
    
    func test_fetchInitialData_changesFetchStatus_toInitialLoading() {
        sut.fetchInitialData()
        XCTAssertEqual(sut.fetchState.value, .initialLoading)
    }
    
    func test_reloadData_makesAPIRequestOneTime() throws {
        let request = try service
            .requestGenerator
            .generateRequestWithHash(requestType: RequestType.get,
                                     relativePath: APIEndpoints.comics.rawValue,
                                     queryParameters: sut.getQueryParametersToFetchData(),
                                     timestampDate: timestampDate)
        sut.reloadData()
        service
            .verifyDataTask(with: request,
                            file: #file,
                            line: #line)
    }
    
    func test_reloadData_changesFetchStatus_toInitialLoading() {
        sut.reloadData()
        XCTAssertEqual(sut.fetchState.value, .reload)
    }
    
    func test_loadingNextPage_makesAPIRequestOneTime() throws {
        let request = try service
            .requestGenerator
            .generateRequestWithHash(requestType: RequestType.get,
                                     relativePath: APIEndpoints.comics.rawValue,
                                     queryParameters: sut.getQueryParametersToFetchData(),
                                     timestampDate: timestampDate)
        sut.fetchNextPage()
        service
            .verifyDataTask(with: request,
                            file: #file,
                            line: #line)
    }
    
    func test_loadingNextPage_changesFetchStatus_toInitialLoading() {
        sut.fetchNextPage()
        XCTAssertEqual(sut.fetchState.value, .loadingNextPage)
    }
}

// MARK: - Helper
extension BaseListVMTests {
    
    func addListItemViewModels() {
        let viewModels: [TestableDataItemVM] = [
            TestableDataItemVM(text: "Zeroth"),
            TestableDataItemVM(text: "First"),
            TestableDataItemVM(text: "Second"),
            TestableDataItemVM(text: "Third"),
            TestableDataItemVM(text: "Fourth"),
            TestableDataItemVM(text: "Fifth"),
            TestableDataItemVM(text: "Sixth"),
        ]
        sut.listItems.value = viewModels
    }
    
    func addData() {
        let data: [TestableData] = [
            TestableData(text: "Zeroth"),
            TestableData(text: "First"),
            TestableData(text: "Second"),
            TestableData(text: "Third"),
            TestableData(text: "Fourth"),
            TestableData(text: "Fifth"),
            TestableData(text: "Sixth"),
        ]
        sut.data = data
    }
}
