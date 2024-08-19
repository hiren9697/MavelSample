//
//  ErrorVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 11/08/24.
//

import Foundation

/// Contains data for ErrorView
/// Used in BaseThumbnailTitleFetchableVM
struct ErrorVM {
    let title: String
    let imageName: String

    init(title: String, imageName: String = "error") {
        self.title = title
        self.imageName = imageName
    }
}
