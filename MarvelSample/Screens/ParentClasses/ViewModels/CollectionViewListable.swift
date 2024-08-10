//
//  ListCollectionViewModel.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 17/07/24.
//

import UIKit
import Combine

/// Designed as abstract class, must be sub-classed
/// Base class for view model class that makes API call and list data
/// Provides state variables for and listItems, which view controller can subscribe
/// Provides generic functionality related to list screen like pagination, reloaod, show error or empty data view
/// Subclass must fill two generic types: 1. Data actual data class, 2. ListItemVM: view models class for liste items
/// Subclass must override method 'parseData(json:)', This class calls this method on successful API call to parse received JSON
/// On intializing object of this class, endPoint, titles for empty and error view must be provided, Optionally API service can be also provided, Injecting API service is very helful in test cases
class BaseListVM<Data, ListItemVM>: APIDataListable {
    // Protocol variables
    let navigationTitle: String?
    var fetchState: CurrentValueSubject<DataFetchState, Never> = CurrentValueSubject(.idle)
    var data: Array<Data> = []
    var listItems: CurrentValueSubject<Array<ListItemVM>, Never> = CurrentValueSubject([])
    // Other variables
    let service: APIServiceProtocol
    let paginationManager: PaginationManager = PaginationManager()
    let endPoint: String
    let emptyDataTitle: String
    let errorTitle: String
    var fetchDataTask: URLSessionDataTask?
    
    init(navigationTitle: String? = nil,
         endPoint: String,
         service: APIServiceProtocol = APIService(requestGenerator: APIRequestGenerator()),
         emptyDataTitle: String,
         errorTitle: String) {
        self.navigationTitle = navigationTitle
        self.endPoint = endPoint
        self.service = service
        self.emptyDataTitle = emptyDataTitle
        self.errorTitle = errorTitle
    }
    
    // Protocol functions
    func itemVM(for row: Int) -> ListItemVM {
        if row == listItems.value.lastIndex &&
            paginationManager.hasMore &&
            fetchDataTask == nil &&
            (fetchState.value != .loadingNextPage ||
             fetchState.value != .initialLoading) {
            fetchNextPage()
        }
        return listItems.value[row]
    }
    
    func fetchInitialData() {
        fetchState.value = .initialLoading
        fetchData()
    }
    
    func reloadData() {
        fetchState.value = .reload
        fetchData()
    }
    
    // Other functions
    func fetchNextPage() {
        fetchState.value = .loadingNextPage
        fetchData()
    }
    
    func parseData(json: Any) {
        fatalError("Must be overridden")
    }
    
    /// Reason the logic to generate query parameters is in specific function outside of 'fetchData' function, is to help test cases uses this function to generate requests and compare that request with MockAPIService
    /// - Returns: Query parameters regarding pagination
    func getQueryParametersToFetchData()-> [String: String] {
        let queryParameters: [String: String] = [
            "limit": "\(paginationManager.limit)",
            "offset": "\(paginationManager.offset)"
        ]
        return queryParameters
    }
    
    /// This is most important function of this class and performs below actions:
    /// 1. Manages pagination, array of list view model and list of data according to fetchState before making API call
    /// 2. Generates URLRequest
    /// 3. Makes API call using generated request
    /// 4. In case of success parses JSON, pagination data and actual data, actual data is parsed with function 'parsePaginationDate(json:)', which needs to be override by subclass and then updates fetchState based on received data
    /// 5. In case of failure updates fetchStatus to error
    func fetchData() {
        // 1. Helper functions
        func parsePaginationDate(json: Any) {
            guard let dict = json as? NSDictionary else {
                return
            }
            guard let data = dict["data"] as? NSDictionary else {
                return
            }
            guard let results = data["results"] as? [NSDictionary] else {
                return
            }
            paginationManager.total = data.getIntValue(key: "total")
            paginationManager.offset += results.count
        }
        func updateFetchStateBasedOnData() {
            if data.isEmpty {
                fetchState.value = .emptyData
            } else {
                fetchState.value = .idle
            }
        }
        // 2. Actual Logic
        if fetchState.value == .reload {
            data.removeAll()
            listItems.value.removeAll()
            paginationManager.reload()
        }
        do {
            let request = try service
                .requestGenerator
                .generateRequestWithHash(requestType: .get,
                                         relativePath: endPoint,
                                         queryParameters: getQueryParametersToFetchData())
            fetchDataTask?.cancel()
            fetchDataTask = nil
            fetchDataTask = service.dataTask(request: request) {[weak self] result in
                defer {
                    self?.fetchDataTask = nil
                }
                switch result {
                case .success(let json):
                    parsePaginationDate(json: json)
                    self?.parseData(json: json)
                    updateFetchStateBasedOnData()
                case .failure(let error):
                    Log.error("Encountered Error in data task: \(error)")
                    self?.fetchState.value = .error(error)
                }
            }
            fetchDataTask?.resume()
        } catch {
            Log.error("Encountered error in generating request: \(error)")
            fetchState.value = .error(error)
        }
    }
}
