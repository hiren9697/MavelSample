//
//  CharacterItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 29/07/24.
//

import Foundation

struct CharacterItemVM: ThumbnailTitleData {
    var loadingState: ListItemLoadingState? = nil
    let title: String
    let thumbnailURL: URL?
    
    init(character: Character) {
        title = character.name
        thumbnailURL = character.thumbnailURL
    }
}
