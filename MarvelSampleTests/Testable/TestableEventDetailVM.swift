//
//  TestableEventDetailVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 07/09/24.
//

import Foundation
@testable import MarvelSample

class TestableEventDetailVM: EventDetailVM {
    
    convenience init(event: Event) {
        self.init(title: event.title,
                  description: event.descriptionText,
                  thumbnailURL: event.thumbnailURL,
                  characterIDs: event.characterIDs,
                  creatorIDs: event.creatorIDs,
                  comicIDs: event.comicIDs,
                  charactersHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Characters",
                                                                                           emptyDataTitle: "No character",
                                                                                           data: event.characterIDs.map { CharacterHorizontalGridItemVM(modelID: $0, service: MockAPIService(requestGenerator: APIRequestGenerator())) }),
                  creatorsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Creators",
                                                                                         emptyDataTitle: "No creator",
                                                                                         data: event.characterIDs.map { CreatorHorizontalGridItemVM(modelID: $0, service: MockAPIService(requestGenerator: APIRequestGenerator())) }),
                  comicsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Comics",
                                                                                       emptyDataTitle: "No comics",
                                                                                       data: event.comicIDs.map { ComicHorizontalGridItemVM(modelID: $0, service: MockAPIService(requestGenerator: APIRequestGenerator())) }))
        
    }
}
