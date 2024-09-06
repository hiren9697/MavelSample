//
//  GenericHorizontalThumbnailTitleGridViewModel.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 03/09/24.
//

import Foundation

/// A generic view model class for horizontal grid
class GenericHorizontalThumbnailTitleGridViewModel<ItemViewModel: ThumbnailTitleItemViewModel>: HorizontalThumbnailTitleGridViewModelProtocol {
    let title: String
    let emptyDataTitle: String
    var data: Array<ItemViewModel>
    
    init(title: String, emptyDataTitle: String, data: Array<ItemViewModel>) {
        self.title = title
        self.emptyDataTitle = emptyDataTitle
        self.data = data
    }
}

extension GenericHorizontalThumbnailTitleGridViewModel: Equatable {
    static func ==(_ lhs: GenericHorizontalThumbnailTitleGridViewModel, _ rhs: GenericHorizontalThumbnailTitleGridViewModel)-> Bool {
        return lhs.title == rhs.title &&
        lhs.emptyDataTitle == rhs.emptyDataTitle &&
        lhs.data == rhs.data
    }
}
