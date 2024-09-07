//
//  EventDetailVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 07/09/24.
//

import Foundation

/// ViewModel for comic detail screen(ComicDetailVC)
class EventDetailVM {
    let title: String
    let description: String
    let thumbnailURL: URL?
    let characterIDs: [String]
    let creatorIDs: [String]
    let comicIDs: [String]
    let charactersHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel<CharacterHorizontalGridItemVM>
    let creatorsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel<CreatorHorizontalGridItemVM>
    let comicsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel<ComicHorizontalGridItemVM>
    
    init(title: String,
         description: String,
         thumbnailURL: URL?,
         characterIDs: [String],
         creatorIDs: [String],
         comicIDs: [String],
         charactersHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel<CharacterHorizontalGridItemVM>,
         creatorsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel<CreatorHorizontalGridItemVM>,
         comicsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel<ComicHorizontalGridItemVM>) {
        self.title = title
        self.description = description
        self.thumbnailURL = thumbnailURL
        self.characterIDs = characterIDs
        self.creatorIDs = creatorIDs
             self.comicIDs = comicIDs
        self.charactersHorizontalGridVM = charactersHorizontalGridVM
        self.creatorsHorizontalGridVM = creatorsHorizontalGridVM
        self.comicsHorizontalGridVM = comicsHorizontalGridVM
    }
    
    convenience init(event: Event) {
        self.init(title: event.title,
                  description: event.descriptionText,
                  thumbnailURL: event.thumbnailURL,
                  characterIDs: event.characterIDs,
                  creatorIDs: event.creatorIDs,
                  comicIDs: event.comicIDs,
                  charactersHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Characters",
                                                                                           emptyDataTitle: "No character",
                                                                                           data: event.characterIDs.map { CharacterHorizontalGridItemVM(modelID: $0) }),
                  creatorsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Creators",
                                                                                         emptyDataTitle: "No creator",
                                                                                         data: event.characterIDs.map { CreatorHorizontalGridItemVM(modelID: $0) }),
                  comicsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Comics",
                                                                                       emptyDataTitle: "No comics",
                                                                                       data: event.comicIDs.map { ComicHorizontalGridItemVM(modelID: $0) }))
        
    }
    
    convenience init() {
        self.init(title: "Hello there, this is a title",
                  description: "Hello there, this is just a description",
                  thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/80/5e3d7536c8ada.jpg")!,
                  characterIDs: [],
                  creatorIDs: [],
                  comicIDs: [],
                  charactersHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Characters",
                                                                                           emptyDataTitle: "No character",
                                                                                           data: []),
                  creatorsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Creators",
                                                                                         emptyDataTitle: "No creator",
                                                                                         data: []),
                  comicsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Comics",
                                                                                       emptyDataTitle: "No comics",
                                                                                       data: []))
    }
}


