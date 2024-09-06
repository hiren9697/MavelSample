//
//  ComicDetailVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 03/08/24.
//

import UIKit

/// ViewModel for comic detail screen(ComicDetailVC)
class ComicDetailVM {
    let title: String
    let description: String
    let thumbnailURL: URL?
    let characterIDs: [String]
    let creatorIDs: [String]
    let charactersHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel<CharacterHorizontalGridItemVM>
    let creatorsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel<CreatorHorizontalGridItemVM>
    
    init(title: String,
         description: String,
         thumbnailURL: URL?,
         characterIDs: [String],
         creatorIDs: [String],
         charactersHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel<CharacterHorizontalGridItemVM>,
         creatorsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel<CreatorHorizontalGridItemVM>) {
        self.title = title
        self.description = description
        self.thumbnailURL = thumbnailURL
        self.characterIDs = characterIDs
        self.creatorIDs = creatorIDs
        self.charactersHorizontalGridVM = charactersHorizontalGridVM
        self.creatorsHorizontalGridVM = creatorsHorizontalGridVM
    }
    
    convenience init(comic: Comic) {
        self.init(title: comic.title,
                  description: comic.descriptionText,
                  thumbnailURL: comic.thumbnailURL,
                  characterIDs: comic.characterIDs,
                  creatorIDs: comic.creatorIDs,
                  charactersHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Characters",
                                                                                           emptyDataTitle: "No character",
                                                                                           data: comic.characterIDs.map { CharacterHorizontalGridItemVM(modelID: $0) }),
                  creatorsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Creators",
                                                                                         emptyDataTitle: "No creator",
                                                                                         data: comic.characterIDs.map { CreatorHorizontalGridItemVM(modelID: $0) }))
    }
    
    convenience init() {
        self.init(title: "Hello there, this is a title",
                  description: "Hello there, this is just a description",
                  thumbnailURL: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/80/5e3d7536c8ada.jpg")!,
                  characterIDs: [],
                  creatorIDs: [],
                  charactersHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Characters",
                                                                                           emptyDataTitle: "No character",
                                                                                           data: []),
                  creatorsHorizontalGridVM: GenericHorizontalThumbnailTitleGridViewModel(title: "Creators",
                                                                                         emptyDataTitle: "No creator",
                                                                                         data: []))
        }
}


