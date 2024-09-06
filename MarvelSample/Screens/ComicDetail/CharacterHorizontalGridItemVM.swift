//
//  CDCharacterItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 04/08/24.
//

import Foundation
import Combine

/// ComicDetailCharacterItemVM
/// ViewModel for single list item of character in comic detail
class CharacterHorizontalGridItemVM: BaseThumbnailTitleFetchableVM<Character> {
    init(modelID: String?,
         service: APIServiceProtocol? = nil) {
        let errorVM = ErrorVM(title: "Couldn't fetch character",
                              imageName: "error")
        super.init(modelID: modelID,
                   endPoint: APIEndpoints.characters.rawValue,
                   errorVM: errorVM,
                   service: service)
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

//extension CharacterHorizontalGridItemVM: Equatable {
//    static func == (lhs: CharacterHorizontalGridItemVM, rhs: CharacterHorizontalGridItemVM) -> Bool {
//        lhs.modelID == rhs.modelID &&
//        lhs.model == rhs.model
//    }
//}
