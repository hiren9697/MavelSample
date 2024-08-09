//
//  CDCharacterItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 04/08/24.
//

import Foundation
import Combine

class CDCharacterItemVM: BaseThumbnailTitleFetchableVM<Character> {
    
    init(modelID: String?) {
        super.init(modelID: modelID,
                   endPoint: APIEndpoints.characters.rawValue)
    }
    
    override func parseModel(from json: Any) -> Character? {
        guard let dictionary = json as? NSDictionary else {
            return nil
        }
        return Character(dict: dictionary)
    }
    
    override func fetchTitleAndThumbnail(from model: Character?) -> (title: String, thumbnail: URL?)? {
        guard let model = model else {
            return nil
        }
        return (model.name, model.thumbnailURL)
    }
}
