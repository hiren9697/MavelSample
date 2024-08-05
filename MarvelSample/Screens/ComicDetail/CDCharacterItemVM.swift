//
//  CDCharacterItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 04/08/24.
//

import Foundation
import Combine

/// Data for character collection view cell in Comic detail
class CDCharacterItemVM: ThumbnailTitleData {
    var dataFetchState: CurrentValueSubject<ListItemLoadingState, Never>? = CurrentValueSubject(.notStarted)
    var title: String
    var thumbnailURL: URL?
    var characterID: String?
    let service = APIService(requestGenerator: APIRequestGenerator())
    var dataFetchTask: URLSessionDataTask?
    
    init(title: String, thumbnailURL: URL?) {
        self.title = title
        self.thumbnailURL = thumbnailURL
    }
    
    init(characterID: String?) {
        self.characterID = characterID
        self.title = ""
        self.thumbnailURL = nil
    }
    
    private func makeRequestToFetchData() {
        
        func parseJSON() {
            
        }
        
        guard let characterID = characterID else {
            return
        }
        guard dataFetchTask == nil else {
            return
        }
        do {
            let request = try service.requestGenerator.generateRequestWithHash(requestType: .get,
                                                                               relativePath: APIEndpoints.characters.rawValue + "/\(characterID)")
            dataFetchTask = service.dataTask(request: request) { result in
                switch result {
                case .success(let json):
                    break
                case .failure(let error):
                    break
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
        }
    }
    
    func fetchData() {
        makeRequestToFetchData()
    }
}
