//
//  ComicDetailVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 03/08/24.
//

import UIKit

class ComicDetailVM {
    let title: String
    let description: String
    let thumbnailURL: URL?
    let characterIDs: [String]
    let characterItemVMs: [CDCharacterItemVM]
    
    init(comic: Comic) {
        title = comic.title
        description = comic.descriptionText
        thumbnailURL = comic.thumbnailURL
        characterIDs = comic.characterIDs
        characterItemVMs = comic.characterIDs.map { CDCharacterItemVM(characterID: $0) }
    }
    
    init() {
        title = "Hello there, this is a title"
        description = "Hello there, this is just a description"
        thumbnailURL = URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/c/80/5e3d7536c8ada.jpg")!
        characterIDs = []
        characterItemVMs = []
    }
    
    func getCharacterItemVM(for index: Int)-> CDCharacterItemVM {
        characterItemVMs[index]
    }
}
