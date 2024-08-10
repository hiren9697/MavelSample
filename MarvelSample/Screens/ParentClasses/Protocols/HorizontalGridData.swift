//
//  HorizontalGridData.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 10/08/24.
//

import Foundation
import Combine

protocol HorizontalGridData {
    associatedtype ItemViewModel: ThumbnailTitleItemViewModelData
    var title: String { get }
    var data: Array<ItemViewModel> { get set }
}
