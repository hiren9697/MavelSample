//
//  ListItemLoadingState.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 10/08/24.
//

import Foundation

/// State of fetch operation in lazy loading list item
enum ListItemLoadingState {
    case notStarted
    case loading
    case loaded
    case failed
}
