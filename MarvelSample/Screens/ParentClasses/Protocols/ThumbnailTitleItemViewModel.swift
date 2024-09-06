//
//  ThumbnailTitleItemViewModelData.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 10/08/24.
//

import Foundation
import Combine

/// Data need to be provided to ThumbnailTitleCC
protocol ThumbnailTitleItemViewModel: Equatable {
    var dataFetchState: CurrentValueSubject<ListItemLoadingState, Never>? { get set }
    var title: String? { get }
    var thumbnailURL: URL? { get }
    var errorVM: ErrorVM? { get }
    
    func fetchData()
}
