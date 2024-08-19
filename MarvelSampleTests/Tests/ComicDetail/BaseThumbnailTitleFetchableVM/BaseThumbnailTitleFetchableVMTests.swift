//
//  BaseThumbnailTitleFetchableVMTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 11/08/24.
//

import XCTest
@testable import MarvelSample

/// Uses TestableChildThumbnailTitleFetchableVM as SUT, as BaseThumbnailTitleFetchableVM is designed as abstract class
/// Uses MockAPIService to mimic api call behaviour
/// Tests:
/// 1. 'fetchData' and 'makeRequestToFetchData' methods tested together as a single unit to test they make API call in expected scenarios with different fetchState, endPoint and modelID

/// NOTE: By default variables: dataFetchState, modelID, encPoint are set non-nil(dataFetchState = .notStarted), Test methods can update them manually before testing
final class BaseThumbnailTitleFetchableVMTests: XCTestCase {
    var sut: TestableChildThumbnailTitleFetchableVM!
    var service: MockAPIService!
    var apiRequestGenerator: TestableAPIRequestGenerator!
    lazy var timestampDate: Date = Date()
    
    override func setUp() {
        super.setUp()
        apiRequestGenerator = TestableAPIRequestGenerator()
        service = MockAPIService(requestGenerator: apiRequestGenerator)
        sut = TestableChildThumbnailTitleFetchableVM(modelID: "0",
                                                     service: service)
    }
    
    override func tearDown() {
        sut = nil
        service = nil
        apiRequestGenerator = nil
        super.tearDown()
    }
}

// MARK: - 1. API Call Tests
/// Testing 'fetchData' and 'makeRequestToFetchData' together as single unit with various states to check they are making API call in expected scenarios
/// The way two methods are written, I can test 'makeRequestToFetchData' separately, But I am not able to test 'fetchData' separately
/// So to test in which scenarios they make API call and in which scenarios they don't make API call below methods are written and tested both methods together
extension BaseThumbnailTitleFetchableVMTests {
    func test_fetchData_whithNilFetchStateNonNilModelIDAndNonNilEndPoint_shouldNotMakeAPICall() {
        sut.dataFetchState = nil
        sut.fetchData()
        _ = service.dataTaskWasNotCalled(file: #file, line: #line)
    }
    
    func test_fetchData_withNonNilFetchStateNilModelIDAdnNonNilEndPoint_shouldNotMakeAPICall() {
        sut.modelID = nil
        _ = service.dataTaskWasNotCalled(file: #file, line: #line)
    }
    
    func test_fetchData_withNonNilFetchStateNonNilModelIDAndNilEndPoint_shouldNotMakeAPICall() {
        sut.endPoint = nil
        _ = service.dataTaskWasNotCalled(file: #file, line: #line)
    }
    
    func test_fetchData_withLoadingFetchStateNonNilModelIDAndNilEndPoint_shouldNotMakeAPICall() {
        sut.dataFetchState?.value = .loading
        _ = service.dataTaskWasNotCalled(file: #file, line: #line)
    }
    
    func test_fetchData_withLoadedFetchStateNonNilModelIDAndNilEndPoint_shouldNotMakeAPICall() {
        sut.dataFetchState?.value = .loaded
        _ = service.dataTaskWasNotCalled(file: #file, line: #line)
    }
    
    func test_fetchData_withFailedFetchStateNonNilModelIDAndNilEndPoint_shouldNotMakeAPICall() {
        sut.dataFetchState?.value = .failed
        _ = service.dataTaskWasNotCalled(file: #file, line: #line)
    }
    
    func test_fetchData_withNotStartedFetchStateNonNilModelIDAndNonNilEndPoint_shouldCallOnceWithCorrectRequest() throws {
        let relativePath = APIEndpoints.creators.rawValue + "/0"
        let request = try service
            .requestGenerator
            .generateRequestWithHash(requestType: RequestType.get,
                                     relativePath: relativePath,
                                     timestampDate: timestampDate)
        sut.fetchData()
        service.verifyDataTask(with: request, file: #file, line: #line)
    }
}

// MARK: - DataFetchState Tests
/// Below methods tests 'fetchData' method updates dataFetchState as expected in various scenarios
/// Method 'makeRequestToFetchData' is private so I am calling 'fetchData' method, because fetchData calls 'makeRequestToFetchData' if dataFetchState is .notStrated and model is nill
/// Tested success and failure response, Didn't test all scenarios of failure response, Because helper class JSONParser is already tested
extension BaseThumbnailTitleFetchableVMTests {
    func test_fetchData_updatesDataFetchStateToLoading_whenStartsAPICall() {
        sut.fetchData()
        XCTAssertEqual(sut.dataFetchState?.value, .loading)
    }
    
    func test_fetchDataAPICall_withFailureResponse_shouldSetFetchStateToFailed() {
        sut.fetchData()
        service.completionArgs.first?(.failure(NetworkError.invalidResponse))
        XCTAssertEqual(sut.dataFetchState?.value, .failed)
    }
    
    func test_fetchDataAPICall_withSuccessResponse_shouldSetFetchStateToLoadedSetModelSetTitleAndThumbnail() {
        guard let model = getModel(line: #line) else {
            return
        }
        sut.fetchData()
        service.completionArgs.first?(.success(getSuccessResponseJSONDictionary(line: #line)!))
        XCTAssertEqual(sut.dataFetchState?.value, .loaded, "dataFetchState is not .loaded")
        XCTAssertEqual(sut.model, model, "parsed model is incorrect")
        XCTAssertEqual(sut.title, model.title, "title is incorrect")
        XCTAssertEqual(sut.thumbnailURL, model.thumbnailURL, "thumbnail is incorrect")
    }
}

// MARK: - Helper
extension BaseThumbnailTitleFetchableVMTests {
    func getSuccessResponseJSONDictionary(line: UInt)-> NSDictionary? {
        guard let json = loadJSON(fileName: "SingleTestableThumbnailTitle") else {
            XCTFail("Precondition: Found JSON nil", line: line)
            return nil
        }
        guard let dictionary = json as? NSDictionary else {
            return nil
        }
        return dictionary
    }
    
    func getModel(line: UInt)-> TestableThumbnailTitleData? {
        guard let json = getSuccessResponseJSONDictionary(line: #line) else {
            XCTFail("Precondition: Found JSON nil")
            return nil
        }
        guard let items = JSONParser().parseListJSON(json) else {
            XCTFail("Precondition: Incorrect JSON", line: line)
            return nil
        }
        guard let item = items.first else {
            XCTFail("Precondition: Empty JSON", line: line)
            return nil
        }
        return TestableThumbnailTitleData(dictionary: item)
    }
}
