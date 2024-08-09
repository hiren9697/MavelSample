//
//  ThumbnailTitleData.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 04/08/24.
//

import UIKit
import Combine

enum ListItemLoadingState {
    case notStarted
    case loading
    case loaded
    case failed
}

/// Data need to be provided to ThumbnailTitleCC
protocol ThumbnailTitleItemViewModelData {
    var dataFetchState: CurrentValueSubject<ListItemLoadingState, Never>? { get set }
    var title: String? { get }
    var thumbnailURL: URL? { get }
    
    func fetchData()
}


protocol HorizontalGridData {
    associatedtype ItemViewModel: ThumbnailTitleItemViewModelData
    var title: String { get }
    var data: Array<ItemViewModel> { get set }
}

final class CharactersGridData: HorizontalGridData {
    let title: String
    var data: [CDCharacterItemVM]
    
    init(title: String = "Characters",
         data: [CDCharacterItemVM]) {
        self.title = title
        self.data = data
    }
}
