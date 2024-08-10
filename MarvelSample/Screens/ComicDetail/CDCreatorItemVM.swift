//
//  CDCreatorItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 10/08/24.
//

import Foundation

class CDCreatorItemVM: BaseThumbnailTitleFetchableVM<Creator> {
    
    init(modelID: String?) {
        super.init(modelID: modelID,
                   endPoint: APIEndpoints.creators.rawValue)
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
