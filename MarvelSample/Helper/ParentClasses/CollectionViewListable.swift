//
//  ListCollectionViewModel.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 17/07/24.
//

import UIKit
import Combine

class BaseListVM<T, U>: APIDataListable {
    // Protocol variables
    var fetchState: CurrentValueSubject<DataFetchState, Never> = CurrentValueSubject(.idle)
    var data: Array<T> = []
    var listItems: CurrentValueSubject<Array<U>, Never> = CurrentValueSubject([])
    // Other variables
    let service: APIServiceProtocol
    let paginationManager: PaginationManager = PaginationManager()
    let endPoint: String
    let emptyDataTitle: String
    let errorTitle: String
    var fetchDataTask: URLSessionDataTask?
    
    init(endPoint: String,
         service: APIServiceProtocol = APIService(requestGenerator: APIRequestGenerator()),
         emptyDataTitle: String,
         errorTitle: String) {
        self.endPoint = endPoint
        self.service = service
        self.emptyDataTitle = emptyDataTitle
        self.errorTitle = errorTitle
    }
    
    // Protocol functions
    func itemVM(for row: Int) -> U {
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
    
    func getQueryParametersToFetchData()-> [String: String] {
        let queryParameters: [String: String] = [
            "limit": "\(paginationManager.limit)",
            "offset": "\(paginationManager.offset)"
        ]
        return queryParameters
    }
    
    func generateRequest(timestampDate: Date? = nil)throws -> URLRequest {
        // Generate request with supplied timestamp
        if let timestampDate = timestampDate {
            return try service
                .requestGenerator
                .generateRequestWithHash(requestType: .get,
                                         relativePath: endPoint,
                                         queryParameters: getQueryParametersToFetchData(),
                                         timestampDate: timestampDate)
        }
        // Generate request without supplying timestamp
        return try service
            .requestGenerator
            .generateRequestWithHash(requestType: .get,
                                     relativePath: endPoint,
                                     queryParameters: getQueryParametersToFetchData())
    }
    
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
            let request = try generateRequest()
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
