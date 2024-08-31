//
//  TestableChildThumbnailTitleFetchableVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 11/08/24.
//

import Foundation
@testable import MarvelSample

/// A class used to fill the space
/// Used in:
/// 1. BaseThumbnailTitleFetchableVM
class TestableChildThumbnailTitleFetchableVM: BaseThumbnailTitleFetchableVM<TestableThumbnailTitleData> {
    init(modelID: String?,
         service: APIServiceProtocol? = nil) {
        let errorVM = ErrorVM(title: "Couldn't fetch TestableChildThumbnailTitleData",
                              imageName: "error")
        super.init(modelID: modelID,
                   endPoint: APIEndpoints.creators.rawValue,
                   errorVM: errorVM,
                   service: service)
    }
    
    override func parseModel(from json: Any) -> TestableThumbnailTitleData? {
        guard let dictionary = json as? NSDictionary else {
            return nil
        }
        return TestableThumbnailTitleData(dictionary: dictionary)
    }
    
    override func fetchTitleAndThumbnail(from model: TestableThumbnailTitleData?) -> (title: String, thumbnail: URL?)? {
        guard let model = model else {
            return nil
        }
        return (model.title, model.thumbnailURL)
    }
}
