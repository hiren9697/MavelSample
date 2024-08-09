//
//  BaseThumbnailTitleFetchableVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 09/08/24.
//

import Foundation
import Combine

/// Base class that provides common functionality for lazy fetchable thumbnail title view model class
class BaseThumbnailTitleFetchableVM<Model>: ThumbnailTitleItemViewModelData {
    // Protocol variables
    var dataFetchState: CurrentValueSubject<ListItemLoadingState, Never>? = CurrentValueSubject(.notStarted)
    var title: String?
    var thumbnailURL: URL?
    // Other variables
    var endPoint: String?
    var modelID: String?
    let service = APIService(requestGenerator: APIRequestGenerator())
    var dataFetchTask: URLSessionDataTask?
    var model: Model?
    
    init(modelID: String?,
         endPoint: String?) {
        self.modelID = modelID
        self.endPoint = endPoint
    }
    
    // Protocol method
    func fetchData() {
        guard let dataFetchState = dataFetchState else {
            return
        }
        if model == nil && dataFetchState.value == .notStarted {
            makeRequestToFetchData()
        }
    }
    
    // Other methods
    private func makeRequestToFetchData() {
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
        
        guard let modelID = modelID else {
            return
        }
        guard dataFetchTask == nil else {
            return
        }
        // API Call
        do {
            let request = try service.requestGenerator.generateRequestWithHash(requestType: .get,
                                                                               relativePath: APIEndpoints.characters.rawValue + "/\(modelID)")
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
