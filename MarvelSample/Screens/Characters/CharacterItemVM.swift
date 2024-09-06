//
//  CharacterItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 29/07/24.
//

import Foundation
import Combine

/// ViewModel for single list item of characters
/// Used in CharactersVC and CharactersVM
struct CharacterItemVM: ThumbnailTitleItemViewModel {
    var dataFetchState: CurrentValueSubject<ListItemLoadingState, Never>? = nil
    let title: String?
    let thumbnailURL: URL?
    let errorVM: ErrorVM? = nil
    
    init(character: Character) {
        title = character.name
        thumbnailURL = character.thumbnailURL
    }
    
    func fetchData() {
        // Do nothing this class doesn't support fetch data
    }
}

extension CharacterItemVM: Equatable {
    static func == (lhs: CharacterItemVM, rhs: CharacterItemVM) -> Bool {
        lhs.title == rhs.title &&
        lhs.thumbnailURL == rhs.thumbnailURL &&
        lhs.errorVM == rhs.errorVM
    }
}
