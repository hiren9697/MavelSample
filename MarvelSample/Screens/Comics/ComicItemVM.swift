//
//  ComicItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 14/07/24.
//

import UIKit
import Combine

struct ComicItemVM: ThumbnailTitleData {
    var dataFetchState: CurrentValueSubject<ListItemLoadingState, Never>? = nil
    let title: String
    let thumbnailURL: URL?
    
    init(comic: Comic) {
        title = comic.title
        thumbnailURL = comic.thumbnailURL
    }
    
    func fetchData() {
        // Do nothing, this class doesn't support fetch data
    }
}
