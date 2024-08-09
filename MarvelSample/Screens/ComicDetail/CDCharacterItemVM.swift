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
    var character: Character?
    
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
            guard let character = Character(dict: characterDictionary) else {
                dataFetchState?.value = .failed
                return
            }
            self.character = character
            // Update Display data
            title = character.name
            thumbnailURL = character.thumbnailURL
            // Update state
            dataFetchState?.value = .loaded
        }
        
        guard let characterID = characterID else {
            return
        }
        guard dataFetchTask == nil else {
            return
        }
        // API Call
        do {
            let request = try service.requestGenerator.generateRequestWithHash(requestType: .get,
                                                                               relativePath: APIEndpoints.characters.rawValue + "/\(characterID)")
            dataFetchTask = service.dataTask(request: request) {[weak self] result in
                switch result {
                case .success(let json):
                    parseJSON(json)
                    break
                case .failure(let error):
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
        }
    }
    
    func fetchData() {
        guard let dataFetchState = dataFetchState else {
            return
        }
        if character == nil && dataFetchState.value == .notStarted {
            makeRequestToFetchData()
        }
    }
}
