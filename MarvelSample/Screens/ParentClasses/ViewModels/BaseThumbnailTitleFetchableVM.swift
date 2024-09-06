//
//  BaseThumbnailTitleFetchableVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 09/08/24.
//

import Foundation
import Combine

/// Base class that provides common functionality for lazy fetchable thumbnail title view model class
class BaseThumbnailTitleFetchableVM<Model>: ThumbnailTitleItemViewModel {
    // Protocol variables
    var dataFetchState: CurrentValueSubject<ListItemLoadingState, Never>? = CurrentValueSubject(.notStarted)
    var title: String?
    var thumbnailURL: URL?
    var errorVM: ErrorVM?
    // Other variables
    var endPoint: String?
    var modelID: String?
    let service: APIServiceProtocol
    var dataFetchTask: URLSessionDataTask?
    var model: Model?
    
    init(modelID: String?,
         endPoint: String?,
         errorVM: ErrorVM?,
         service: APIServiceProtocol? = nil) {
        self.modelID = modelID
        self.endPoint = endPoint
        self.errorVM = errorVM
        self.service = service ?? APIService(requestGenerator: APIRequestGenerator())
    }
    
    // Protocol method
    func fetchData() {
        guard let dataFetchState = dataFetchState else {
            return
        }
        guard dataFetchState.value == .notStarted else {
            return
        }
        guard model == nil else {
            return
        }
        guard let modelID = modelID else {
            return
        }
        guard let endPoint = endPoint else {
            return
        }
        guard dataFetchTask == nil else {
            return
        }
        makeRequestToFetchData(modelID: modelID,
                               endPoint: endPoint)
    }
    
    // Other methods
    private func makeRequestToFetchData(modelID: String, endPoint: String) {
        // Helper function
        func parseJSON(_ json: Any) {
            // Parse JSON
            guard let results = JSONParser().parseListJSON(json) else {
                dataFetchState?.value = .failed
                return
            }
            guard let characterDictionary = results.first else {
                dataFetchState?.value = .failed
                return
            }
            guard let model = parseModel(from: characterDictionary) else {
                dataFetchState?.value = .failed
                return
            }
            
            self.model = model
            // Update Display data
            guard let titleThumbnailTuple = fetchTitleAndThumbnail(from: self.model) else {
                dataFetchState?.value = .failed
                return
            }
            title = titleThumbnailTuple.title
            thumbnailURL = titleThumbnailTuple.thumbnail
            // Update state
            dataFetchState?.value = .loaded
        }
        
        // API Call
        do {
            let request = try service.requestGenerator.generateRequestWithHash(requestType: .get,
                                                                               relativePath: endPoint + "/\(modelID)")
            dataFetchTask = service.dataTask(request: request) {[weak self] result in
                switch result {
                case .success(let json):
                    parseJSON(json)
                    break
                case .failure(let error):
                    Log.error("Encountered error in fetching title thumbnail: \(error)")
                    self?.dataFetchState?.value = .failed
                }
            }
            dataFetchTask?.resume()
            if let dataFetchState = dataFetchState {
                dataFetchState.value = .loading
            } else {
                dataFetchState = CurrentValueSubject(.notStarted)
                dataFetchState?.value = .loading
            }
        } catch {
            Log.error("Error in generating character detail request: \(error)")
            dataFetchState?.value = .failed
        }
    }
    
    func parseModel(from json: Any)-> Model? {
        // Sub class needs to override this
        fatalError("Sub class needs to override this")
    }
    
    func fetchTitleAndThumbnail(from model: Model?)-> (title: String, thumbnail: URL?)? {
       // Sub class needs to override this
        fatalError("Sub class needs to override this")
    }
}

extension BaseThumbnailTitleFetchableVM: Equatable {
    static func ==(_ lhs: BaseThumbnailTitleFetchableVM, _ rhs: BaseThumbnailTitleFetchableVM)-> Bool {
        return lhs.title == rhs.title &&
        lhs.thumbnailURL == rhs.thumbnailURL &&
        lhs.errorVM == rhs.errorVM
    }
}
