//
//  ComicsVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 14/07/24.
//

import UIKit
import Combine

enum DataFetchState {
    case initialLoading
    case loadingNextPage
    case idle
    case error(Error)
    case emptyData
}

extension DataFetchState: Equatable {
    static func == (lhs: DataFetchState, rhs: DataFetchState) -> Bool {
            switch (lhs, rhs) {
            case (.initialLoading, .initialLoading):
                return true
            case (.loadingNextPage, .loadingNextPage):
                return true
            case (.idle, .idle):
                return true
            case (.emptyData, .emptyData):
                return true
            case (.error(_), .error(_)):
                return true
            default:
                return false
            }
        }
}

class PaginationManager {
    let limit: Int
    var offset: Int = 0
    var total: Int? = nil
    var hasMore: Bool {
        guard let total = total else {
            return true
        }
        return offset < total
    }
    
    init(limit: Int = 10) {
        self.limit = limit
    }
}

// MARK: - VM
class ComicsVM {
    let paginationManager = PaginationManager()
    let service = APIService()
    var fetchComicsTask: URLSessionDataTask?
    var fetchState: CurrentValueSubject<DataFetchState, Never> = CurrentValueSubject(.idle)
    var comics: [Comic] = []
    var comicItems: CurrentValueSubject<[ComicItemVM], Never> = CurrentValueSubject([])
}

// MARK: - Helper
extension ComicsVM {
    func itemVM(for row: Int)-> ComicItemVM {
        if row == comicItems.value.lastIndex &&
            paginationManager.hasMore &&
            fetchComicsTask == nil &&
            (fetchState.value != .loadingNextPage ||
             fetchState.value != .initialLoading) {
            fetchComics()
        }
        return comicItems.value[row]
    }
}

// MARK: - API
extension ComicsVM {
    
    func fetchComics() {
        /*
        func parseComics(json: Any) {
            guard let dict = json as? NSDictionary else {
                return
            }
            guard let data = dict["data"] as? NSDictionary else {
                return
            }
            guard let results = data["results"] as? [NSDictionary] else {
                return
            }
            var newComics: [Comic] = []
            var newComicItems: [ComicItemVM] = []
            for item in results {
                if let comic = Comic(dict: item) {
                    newComics.append(comic)
                    newComicItems.append(ComicItemVM(comic: comic))
                }
            }
            comics.append(contentsOf: newComics)
            comicItems.value.append(contentsOf: newComicItems)
        }
        
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
        
        let queryParameters: [String: String] = [
            "limit": "\(paginationManager.limit)",
            "offset": "\(paginationManager.offset)"
        ]
        
        do {
            let request = try service.generateRequest(requestType: .get,
                                                      relativePath: APIEndpoints.comics.rawValue,
                                                      queryParameters: queryParameters)
            fetchComicsTask?.cancel()
            fetchComicsTask = nil
            fetchComicsTask = service.dataTask(request: request) {[weak self] result in
                guard let strongSelf = self else {
                    return
                }
                defer {
                    strongSelf.fetchComicsTask = nil
                }
                switch result {
                case .success(let json):
                    parsePaginationDate(json: json)
                    parseComics(json: json)
                    if strongSelf.comics.isEmpty {
                        strongSelf.fetchState.value = .emptyData
                    } else {
                        strongSelf.fetchState.value = .idle
                    }
                case .failure(let error):
                    Log.error("Encountered Error in data task: \(error)")
                    strongSelf.fetchState.value = .error(error)
                }
            }
            fetchState.value = comics.isEmpty ? .initialLoading : .loadingNextPage
            fetchComicsTask?.resume()
        } catch {
            Log.error("Encountered error in generating request: \(error)")
            fetchState.value = .error(error)
        }
         */
        fetchState.value = .emptyData
    }
}
