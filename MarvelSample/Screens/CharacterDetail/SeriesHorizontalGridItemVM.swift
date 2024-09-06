//
//  SeriesHorizontalGridItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 02/09/24.
//

import Foundation

/// ViewModel for single list item of series in horizontal grid
class SeriesHorizontalGridItemVM: BaseThumbnailTitleFetchableVM<Series> {
    init(modelID: String?,
         service: APIServiceProtocol? = nil) {
        let errorVM = ErrorVM(title: "Couldn't fetch series",
                              imageName: "error")
        super.init(modelID: modelID,
                   endPoint: APIEndpoints.series.rawValue,
                   errorVM: errorVM,
                   service: service)
    }
    
    override func parseModel(from json: Any) -> Series? {
        guard let dictionary = json as? NSDictionary else {
            return nil
        }
        return Series(dict: dictionary)
    }
    
    override func fetchTitleAndThumbnail(from model: Series?) -> (title: String, thumbnail: URL?)? {
        guard let model = model else {
            return nil
        }
        return (model.title, model.thumbnailURL)
    }
}

//extension SeriesHorizontalGridItemVM: Equatable {
//    static func == (lhs: SeriesHorizontalGridItemVM, rhs: SeriesHorizontalGridItemVM) -> Bool {
//        lhs.modelID == rhs.modelID &&
//        lhs.model == rhs.model
//    }
//}
