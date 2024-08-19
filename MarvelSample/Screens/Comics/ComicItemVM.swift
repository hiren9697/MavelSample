//
//  ComicItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 14/07/24.
//

import UIKit
import Combine

/// ViewModel for single item of comic list
struct ComicItemVM: ThumbnailTitleItemViewModel {
    var dataFetchState: CurrentValueSubject<ListItemLoadingState, Never>? = nil
    let title: String?
    let thumbnailURL: URL?
    let errorVM: ErrorVM? = nil
    
    init(comic: Comic) {
        title = comic.title
        thumbnailURL = comic.thumbnailURL
    }
    
    func fetchData() {
        // Do nothing, this class doesn't support fetch data
    }
}
