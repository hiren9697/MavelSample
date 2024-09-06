//
//  TestableCharacterDetailVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 05/09/24.
//

import Foundation
@testable import MarvelSample

class TestableCharacterDetailVM: CharacterDetailVM {
    convenience init(character: Character) {
        self.init(name: character.name,
                  thumbnailURL: character.thumbnailURL,
                  comicIDs: character.comicIDs,
                  seriesIDs: character.seriesIDs,
                  comicsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Comics",
                                                                                       emptyDataTitle: "No comics",
                                                                                       data: character.comicIDs.map { ComicHorizontalGridItemVM(modelID: $0,
                                                                                                                                                service: MockAPIService(requestGenerator: APIRequestGenerator())) }),
                  seriesHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Series",
                                                                                       emptyDataTitle: "No series",
                                                                                       data: character.seriesIDs.map { SeriesHorizontalGridItemVM(modelID: $0,
                                                                                                                                                  service: MockAPIService(requestGenerator: APIRequestGenerator())) }))
        
    }
}
