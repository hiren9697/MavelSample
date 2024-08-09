//
//  CharacterItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 29/07/24.
//

import Foundation
import Combine

struct CharacterItemVM: ThumbnailTitleItemViewModelData {
    var dataFetchState: CurrentValueSubject<ListItemLoadingState, Never>? = nil
    let title: String?
    let thumbnailURL: URL?
    
    init(character: Character) {
        title = character.name
        thumbnailURL = character.thumbnailURL
    }
    
    func fetchData() {
        // Do nothing this class doesn't support fetch data
    }
}
