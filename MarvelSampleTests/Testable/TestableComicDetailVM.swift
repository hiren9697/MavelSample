//
//  TestableComicDetailVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 04/09/24.
//

import Foundation
@testable import MarvelSample

/// Testable sub-class of ComicDetailVM that initializes horizontal grids with MockAPIService
class TestableComicDetailVM: ComicDetailVM {
    override init(title: String,
                  description: String,
                  thumbnailURL: URL?,
                  characterIDs: [String],
                  creatorIDs: [String],
                  charactersHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel<CharacterHorizontalGridItemVM>,
                  creatorsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel<CreatorHorizontalGridItemVM>) {
        super.init(title: title,
                   description: description,
                   thumbnailURL: thumbnailURL,
                   characterIDs: characterIDs,
                   creatorIDs: creatorIDs,
                   charactersHorizontalGridVM: charactersHorizontalGridVM,
                   creatorsHorizontalGridVM: creatorsHorizontalGridVM)
    }
    
    convenience init(comic: Comic) {
        self.init(title: comic.title,
                  description: comic.descriptionText,
                  thumbnailURL: comic.thumbnailURL,
                  characterIDs: comic.characterIDs,
                  creatorIDs: comic.creatorIDs,
                  charactersHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Characters",
                                                                                           emptyDataTitle: "No character",
                                                                                           data: comic.characterIDs.map { CharacterHorizontalGridItemVM(modelID: $0,
                                                                                                                                                        service: MockAPIService(requestGenerator: APIRequestGenerator())) }),
                  creatorsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Creators",
                                                                                         emptyDataTitle: "No creator",
                                                                                         data: comic.characterIDs.map { CreatorHorizontalGridItemVM(modelID: $0,
                                                                                                                                                    service: MockAPIService(requestGenerator: APIRequestGenerator())) }))
    }
}
