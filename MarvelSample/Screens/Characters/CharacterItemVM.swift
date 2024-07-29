//
//  CharacterItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 29/07/24.
//

import Foundation

struct CharacterItemVM {
    let name: String
    let thumbnailURL: URL?
    
    init(character: Character) {
        name = character.name
        thumbnailURL = character.thumbnailURL
    }
}
