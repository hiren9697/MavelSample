//
//  CDCreatorItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 10/08/24.
//

import Foundation

class CDCreatorItemVM: BaseThumbnailTitleFetchableVM<Creator> {
    
    init(modelID: String?,
         service: APIServiceProtocol? = nil) {
        let errorVM = ErrorVM(title: "Couldn't fetch creator",
                              imageName: "error")
        super.init(modelID: modelID,
                   endPoint: APIEndpoints.creators.rawValue,
                   errorVM: errorVM,
                   service: service)
    }
    
    override func parseModel(from json: Any) -> Creator? {
        guard let dictionary = json as? NSDictionary else {
            return nil
        }
        return Creator(dict: dictionary)
    }
    
    override func fetchTitleAndThumbnail(from model: Creator?) -> (title: String, thumbnail: URL?)? {
        guard let model = model else {
            return nil
        }
        return (model.fullName, model.thumbnailURL)
    }
}

extension CDCreatorItemVM: Equatable {
    static func == (lhs: CDCreatorItemVM, rhs: CDCreatorItemVM) -> Bool {
        lhs.modelID == rhs.modelID &&
        lhs.model == rhs.model
    }
}
