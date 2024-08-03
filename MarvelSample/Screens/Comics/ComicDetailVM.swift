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
    
    init(comic: Comic) {
        title = comic.title
        description = comic.descriptionText
        thumbnailURL = comic.thumbnailURL
    }
}
