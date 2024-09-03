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
    
    init(character: Character) {
        name = character.name
        thumbnailURL = character.thumbnailURL
        comicIDs = character.comicIDs
        seriesIDs = character.seriesIDs
    }
    
    init() {
        name = "Hello there, this is a title"
        thumbnailURL = URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/80/5e3d7536c8ada.jpg")!
        comicIDs = []
        seriesIDs = []
    }
}
