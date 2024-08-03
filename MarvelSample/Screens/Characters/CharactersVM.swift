//
//  CharactersVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 29/07/24.
//

import Foundation

class CharactersVM: BaseListVM<Character, CharacterItemVM> {
    
    init(service: APIServiceProtocol = APIService(requestGenerator: APIRequestGenerator())) {
        super.init(navigationTitle: "Characters",
                   endPoint: APIEndpoints.characters.rawValue,
                   service: service,
                   emptyDataTitle: "Couldn't find any characters",
                   errorTitle: "Error in fetching characters")
    }
    
    override func parseData(json: Any) {
        guard let dict = json as? NSDictionary else {
            return
        }
        guard let data = dict["data"] as? NSDictionary else {
            return
        }
        guard let results = data["results"] as? [NSDictionary] else {
            return
        }
        var newCharacters: [Character] = []
        var newCharacterItems: [CharacterItemVM] = []
        for item in results {
            if let character = Character(dict: item) {
                Log.info(character)
                newCharacters.append(character)
                newCharacterItems.append(CharacterItemVM(character: character))
            }
        }
        self.data.append(contentsOf: newCharacters)
        listItems.value.append(contentsOf: newCharacterItems)
    }
}
