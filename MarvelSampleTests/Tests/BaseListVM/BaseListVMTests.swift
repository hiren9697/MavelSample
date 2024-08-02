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
        service = nil
        apiRequestGenerator = nil
        super.tearDown()
    }
}

// MARK: - ListItem Tests
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
    
    func test_onFetchingLiastItemVM_fetchingNextPage() {
        addListItemViewModels()
        XCTAssertEqual(service.dataTaskCallCount, 0, "Precondition")
        _ = sut.itemVM(for: 6)
        _ = service.dataTaskWasCalledOnce(file: #file, line: #line)
    }
}

// MARK: - Data fetch function tests
extension BaseListVMTests {
    
    func test_fetchInitialData_makesAPIRequestOneTime() throws {
        XCTAssertEqual(service.dataTaskCallCount, 0, "Precondition")
        sut.fetchInitialData()
        _ = service.dataTaskWasCalledOnce(file: #file, line: #line)
    }
    
    func test_fetchInitialData_changesFetchStatus_toInitialLoading() {
        sut.fetchInitialData()
        XCTAssertEqual(sut.fetchState.value, .initialLoading)
    }
    
    func test_reloadData_makesAPIRequestOneTime() throws {
        XCTAssertEqual(service.dataTaskCallCount, 0, "Precondition")
        sut.reloadData()
        _ = service.dataTaskWasCalledOnce(file: #file, line: #line)
    }
    
    func test_reloadData_changesFetchStatus_toInitialLoading() {
        sut.reloadData()
        XCTAssertEqual(sut.fetchState.value, .reload)
    }
    
    func test_loadingNextPage_makesAPIRequestOneTime() throws {
        XCTAssertEqual(service.dataTaskCallCount, 0, "Precondition")
        sut.fetchNextPage()
        _ = service.dataTaskWasCalledOnce(file: #file, line: #line)
    }
    
    func test_loadingNextPage_changesFetchStatus_toInitialLoading() {
        sut.fetchNextPage()
        XCTAssertEqual(sut.fetchState.value, .loadingNextPage)
    }
    
    func test_fetchData_makingAPICallWithCorrectRequest() throws {
        let request = try service
            .requestGenerator
            .generateRequestWithHash(requestType: RequestType.get,
                                     relativePath: APIEndpoints.comics.rawValue,
                                     queryParameters: sut.getQueryParametersToFetchData(),
                                     timestampDate: timestampDate)
        sut.fetchData()
        service
            .verifyDataTask(with: request,
                            file: #file,
                            line: #line)
    }
}

// MARK: - Helper method tests
extension BaseListVMTests {
    
    func test_getQueryParameters_givesCorrectParameters() {
        let queryParameters: [String: String] = [
            "limit": "\(sut.paginationManager.limit)",
            "offset": "\(sut.paginationManager.offset)"
        ]
        XCTAssertEqual(sut.getQueryParametersToFetchData(), queryParameters)
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
            TestableData(text: "Sixth")
        ]
        sut.data = data
    }
}
