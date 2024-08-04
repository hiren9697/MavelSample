//
//  CDCharacterItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 04/08/24.
//

import Foundation

/// Data for character collection view cell in Comic detail
class CDCharacterItemVM: ThumbnailTitleData {
    let title: String
    let thumbnailURL: URL?
    
    init(title: String, thumbnailURL: URL?) {
        self.title = title
        self.thumbnailURL = thumbnailURL
    }
}
