//
//  CharacterDetailVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 02/09/24.
//

import Foundation

/// ViewModel for character detail screen(CharacterDetailVC)
class CharacterDetailVM {
    let name: String
    let thumbnailURL: URL?
    let comicIDs: [String]
    let seriesIDs: [String]
    let comicsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel<ComicHorizontalGridItemVM>
    let seriesHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel<SeriesHorizontalGridItemVM>
    
    init(name: String,
         thumbnailURL: URL?,
         comicIDs: [String],
         seriesIDs: [String],
         comicsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel<ComicHorizontalGridItemVM>,
         seriesHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel<SeriesHorizontalGridItemVM>) {
        self.name = name
        self.thumbnailURL = thumbnailURL
        self.comicIDs = comicIDs
        self.seriesIDs = seriesIDs
        self.comicsHorizontalGridVM = comicsHorizontalGridVM
        self.seriesHorizontalGridVM = seriesHorizontalGridVM
    }
    
    
    convenience init(character: Character) {
        self.init(name: character.name,
                  thumbnailURL: character.thumbnailURL,
                  comicIDs: character.comicIDs,
                  seriesIDs: character.seriesIDs,
                  comicsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Comics",
                                                                                       emptyDataTitle: "No comics",
                                                                                       data: character.comicIDs.map { ComicHorizontalGridItemVM(modelID: $0) }),
                  seriesHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Series",
                                                                                       emptyDataTitle: "No series",
                                                                                       data: character.seriesIDs.map { SeriesHorizontalGridItemVM(modelID: $0) }))
        
    }
    
    convenience init() {
        self.init(name: "Hello there, this is a title",
                  thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/80/5e3d7536c8ada.jpg")!,
                  comicIDs: [],
                  seriesIDs: [],
                  comicsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Comics",
                                                                                  emptyDataTitle: "No comic",
                                                                                  data: []),
                  seriesHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Series",
                                                                                  emptyDataTitle: "No series",
                                                                                  data: []))
        }
}
