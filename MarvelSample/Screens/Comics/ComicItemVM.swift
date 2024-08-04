//
//  ComicItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 14/07/24.
//

import UIKit

struct ComicItemVM: ThumbnailTitleData {
    let title: String
    let thumbnailURL: URL?
    
    init(comic: Comic) {
        title = comic.title
        thumbnailURL = comic.thumbnailURL
    }
}
