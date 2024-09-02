//
//  CRDComicItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 02/09/24.
//

import Foundation
/// CharacterDetailComicItemVM
/// ViewModel for single list item of character in comic detail
class CRDComicItemVM: BaseThumbnailTitleFetchableVM<Comic> {
    init(modelID: String?,
         service: APIServiceProtocol? = nil) {
        let errorVM = ErrorVM(title: "Couldn't fetch character",
                              imageName: "error")
        super.init(modelID: modelID,
                   endPoint: APIEndpoints.comics.rawValue,
                   errorVM: errorVM,
                   service: service)
    }
    
    override func parseModel(from json: Any) -> Comic? {
        guard let dictionary = json as? NSDictionary else {
            return nil
        }
        return Comic(dict: dictionary)
    }
    
    override func fetchTitleAndThumbnail(from model: Comic?) -> (title: String, thumbnail: URL?)? {
        guard let model = model else {
            return nil
        }
        return (model.title, model.thumbnailURL)
    }
}

extension CRDComicItemVM: Equatable {
    static func == (lhs: CRDComicItemVM, rhs: CRDComicItemVM) -> Bool {
        lhs.modelID == rhs.modelID &&
        lhs.model == rhs.model
    }
}
