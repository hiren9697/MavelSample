//
//  StoryHorizontalGridItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 02/09/24.
//

import Foundation

/// ViewModel for single list item of stories in horizontal grid
class StoryHorizontalGridItemVM: BaseThumbnailTitleFetchableVM<Story> {
    init(modelID: String?,
         service: APIServiceProtocol? = nil) {
        let errorVM = ErrorVM(title: "Couldn't fetch story",
                              imageName: "error")
        super.init(modelID: modelID,
                   endPoint: APIEndpoints.series.rawValue,
                   errorVM: errorVM,
                   service: service)
    }
    
    override func parseModel(from json: Any) -> Story? {
        guard let dictionary = json as? NSDictionary else {
            return nil
        }
        return Story(dict: dictionary)
    }
    
    override func fetchTitleAndThumbnail(from model: Story?) -> (title: String, thumbnail: URL?)? {
        guard let model = model else {
            return nil
        }
        return (model.title, model.thumbnailURL)
    }
}

extension StoryHorizontalGridItemVM: Equatable {
    static func == (lhs: StoryHorizontalGridItemVM, rhs: StoryHorizontalGridItemVM) -> Bool {
        lhs.modelID == rhs.modelID &&
        lhs.model == rhs.model
    }
}
