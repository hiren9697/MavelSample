//
//  BaseListVMTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 25/07/24.
//

import XCTest
@testable import MarvelSample

/// Tests:
/// 1. Returns correct ListItem
/// 2. Data fetch functions making API call & updating fetchState
/// 3. Helper methods
/// NOTE:
/// - Uses TestableBaseListVM as SUT, as BaseListVM is designed as abstract class
/// - Uses MockAPIService to mimic api call behaviour
/// - Uses TestableAPIRequestGenerator, see description of 'TestableAPIRequestGenerator', to know why this class exist
// MARK: - Test Class
final class BaseListVMTests: XCTestCase {
    var sut: TestableBaseListVM!
    var service: MockAPIService!
    var apiRequestGenerator: TestableAPIRequestGenerator!
    lazy var timestampDate: Date = Date()
    var lastDataIndex: Int {
        sut.data.count - 1
    }
    
    override func setUp() {
        super.setUp()
        apiRequestGenerator = TestableAPIRequestGenerator()
        service = MockAPIService(requestGenerator: apiRequestGenerator)
        sut = TestableBaseListVM(endpoint: TestAPIEndpoints.common.rawValue,
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

// MARK: - 1. Returns correct ListItem
extension BaseListVMTests {
    func test_listItem_returnsCorrectListItemVM() {
        // addListItemViewModels()
        makeInitialAPICallToLoadData(line: #line)
        let zerothVM = sut.itemVM(for: 0)
        XCTAssertEqual(zerothVM.text, "Zeroth")
        let firstVM = sut.itemVM(for: 1)
        XCTAssertEqual(firstVM.text, "First")
        let lastVM = sut.itemVM(for: 6)
        XCTAssertEqual(lastVM.text, "Sixth")
    }
}

// MARK: - 2. Data fetch functions making API call & updating fetchState
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
                                     relativePath: TestAPIEndpoints.common.rawValue,
                                     queryParameters: sut.getQueryParametersToFetchData(),
                                     timestampDate: timestampDate)
        sut.fetchData()
        service
            .verifyDataTask(with: request,
                            file: #file,
                            line: #line)
    }
}

// MARK: - 3. Triger fetchNextPage
extension BaseListVMTests {
    /// Arrange all condition positive to trigger fetchNextPage(), fetch last list item view model should trigger fetchNextPage()
    func test_onFetchingLastItemVM_withAllRequiredConditionPositive_shouldfetchingNextPage() {
        // Arrange
        makeInitialAPICallToLoadData(line: #line)
        _ = service.dataTaskWasCalledOnce(file: #file, line: #line)
        XCTAssertEqual(sut.fetchState.value, .idle, "Precondition")
        // Act
        _ = sut.itemVM(for: lastDataIndex)
        // Assert
        _ = service.dataTaskWasCalledTwice(file: #file, line: #line)
    }
    
    /// Arrange all condition positive to trigger fetchNextPage(), fetch second last list item view model, should not trigger fetchNextPage()
    func test_onFetchingSecondLastItemVM_withAllRequiredConditionPositive_shouldNotFetchNextPage() {
        // Arrange
        makeInitialAPICallToLoadData(line: #line)
        _ = service.dataTaskWasCalledOnce(file: #file, line: #line)
        XCTAssertEqual(sut.fetchState.value, .idle, "Precondition")
        // Act
        _ = sut.itemVM(for: lastDataIndex - 1)
        // Assert
        _ = service.dataTaskWasCalledOnce(file: #file, line: #line)
    }
    
    /// Arrange all condition positive to trigger fetchNextPage(), except 'hasMore' of paginationManager, should not trigger fetchNextPage()
    func test_onFetchingLastItemVM_withAllRequiredConditionPositiveExceptPaginationHasMore_shouldNotFetchNextPage() {
        // Arrange
        makeInitialAPICallToLoadData(line: #line)
        _ = service.dataTaskWasCalledOnce(file: #file, line: #line)
        XCTAssertEqual(sut.fetchState.value, .idle, "Precondition")
        // Act
        sut.paginationManager.offset = sut.paginationManager.total ?? 0 // Negative condition, This is to make hasMore false
        _ = sut.itemVM(for: lastDataIndex)
        // Assert
        _ = service.dataTaskWasCalledOnce(file: #file, line: #line)
    }
    
    /// Arrange all condition positive to trigger fetchNextPage(), except fetchDataTask, should not trigger fetchNextPage()
    func test_onFetchingLastItemVM_withAllRequiredConditionPositiveExceptDataTaskNonNil_shouldNotFetchNextPage() {
        // Arrange
        makeInitialAPICallToLoadData(line: #line)
        _ = service.dataTaskWasCalledOnce(file: #file, line: #line)
        XCTAssertEqual(sut.fetchState.value, .idle, "Precondition")
        // Act
        sut.fetchDataTask = URLSessionDataTask() // Negative condition
        _ = sut.itemVM(for: lastDataIndex)
        // Assert
        _ = service.dataTaskWasCalledOnce(file: #file, line: #line)
    }
    
    /// Arrange all condition positive to trigger fetchNextPage(), except fetchState loadingNextPage, should not trigger fetchNextPage()
    func test_onFetchingLastItemVM_withAllRequiredConditionPositiveExceptFetchStateLoadingNextPage_shouldNotFetchNextPage() {
        // Arrange
        makeInitialAPICallToLoadData(line: #line)
        _ = service.dataTaskWasCalledOnce(file: #file, line: #line)
        XCTAssertEqual(sut.fetchState.value, .idle, "Precondition")
        // Act
        sut.fetchState.value = .loadingNextPage // Negative condition
        _ = sut.itemVM(for: lastDataIndex)
        // Assert
        _ = service.dataTaskWasCalledOnce(file: #file, line: #line)
    }
    
    /// Arrange all condition positive to trigger fetchNextPage(), except fetchState initialLoading, should not trigger fetchNextPage()
    func test_onFetchingLastItemVM_withAllRequiredConditionPositiveExceptFetchStateInitalLoading_shouldNotFetchNextPage() {
        // Arrange
        makeInitialAPICallToLoadData(line: #line)
        _ = service.dataTaskWasCalledOnce(file: #file, line: #line)
        XCTAssertEqual(sut.fetchState.value, .idle, "Precondition")
        // Act
        sut.fetchState.value = .initialLoading // Negative condition
        _ = sut.itemVM(for: lastDataIndex)
        // Assert
        _ = service.dataTaskWasCalledOnce(file: #file, line: #line)
    }
}

// MARK: - 4. fetchData
extension BaseListVMTests {
    func test_fetchData_finishWithInvalidURLError_shouldHandleInvalidURL() {
        // Arange
        sut = TestableBaseListVM(endpoint: "invalid endpoint",
                                 emptyDataTitle: "-",
                                 errorTitle: "-",
                                 service: MockAPIService(requestGenerator: APIRequestGenerator()))
        // Act
        sut.fetchData()
        // Assert
        XCTAssertEqual(sut.fetchState.value, .error(NetworkError.invalidURL))
    }
    
    func test_fetchData_finishWithInvalidResponseError_shouldHandleErrorResponse() {
        sut.fetchData()
        service.completionArgs.first?(.failure(NetworkError.invalidResponse))
        XCTAssertEqual(sut.fetchState.value, .error(NetworkError.invalidResponse))
    }
    
    func test_fetchData_finishWithSuccessResponse_shouldSetPaginatinationDataCorrect() {
        guard let json = loadJSON(fileName: "TestableData") else {
            XCTFail("Couldn't load JSON")
            return
        }
        sut.fetchData()
        service.completionArgs.first?(.success(json))
        XCTAssertEqual(sut.paginationManager.total, 500)
        XCTAssertEqual(sut.paginationManager.limit, 10)
        XCTAssertEqual(sut.paginationManager.offset, 10)
    }
    
    func test_fetchData_updatesFetchStateToEmptyData_onReceivingEmptyJSON() {
        guard let json = loadJSON(fileName: "EmptyList") else {
            XCTFail("Couldn't load JSON")
            return
        }
        sut.fetchData()
        service.completionArgs.first?(.success(json))
        XCTAssertEqual(sut.fetchState.value, .emptyData)
    }
    
    func test_fetchData_updatesFetchStateToIdle_onReceivingNonEmptyJSON() {
        guard let json = loadJSON(fileName: "TestableData") else {
            XCTFail("Couldn't load JSON")
            return
        }
        sut.fetchData()
        service.completionArgs.first?(.success(json))
        XCTAssertEqual(sut.fetchState.value, .idle)
    }
    
    func test_reload_shouldRemoveExistingData() {
        guard let json = loadJSON(fileName: "TestableData") else {
            XCTFail("Couldn't load JSON")
            return
        }
        // Make API call first time to load data
        sut.fetchData()
        service.completionArgs.first?(.success(json))
        XCTAssertEqual(sut.data.count, 10, "Precondition")
        XCTAssertEqual(sut.listItems.value.count, 10, "Precondition")
        XCTAssertEqual(sut.paginationManager.offset, 10, "Precondition")
        // Reload data
        sut.reloadData()
        service.completionArgs[1](.success(json))
        XCTAssertEqual(sut.data.count, 10)
        XCTAssertEqual(sut.listItems.value.count, 10)
        XCTAssertEqual(sut.paginationManager.offset, 10)
    }
}

// MARK: - 4. Helper method tests
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
    func makeInitialAPICallToLoadData(line: UInt) {
        guard let json = loadJSON(fileName: "TestableData") else {
            XCTFail("Couldn't load JSON", line: line)
            return
        }
        sut.fetchData()
        service.completionArgs.first?(.success(json))
    }
}
