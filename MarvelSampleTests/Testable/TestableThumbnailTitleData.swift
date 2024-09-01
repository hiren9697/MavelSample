//
//  TestableThumbnailTitleData.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 13/08/24.
//

import Foundation
import Combine
@testable import MarvelSample

/// Dummy class used to fill the space
/// Used in:
/// 1. TestableChildThumbnailTitleFetchableVM
/// 2. BaseThumbnailTitleFetchableVMTests
struct TestableThumbnailTitleData {
    let id: String
    let title: String
    let thumbnailURLString: String
    var thumbnailURL: URL? {
        return URL(string: thumbnailURLString)
    }
    
    init(dictionary: NSDictionary) {
        id = dictionary.getStringValue(key: "id")
        title = dictionary.getStringValue(key: "title")
        thumbnailURLString = dictionary.getStringValue(key: "thumbnail")
    }
}

extension TestableThumbnailTitleData: Equatable {
    static func ==(_ lhs: TestableThumbnailTitleData, _ rhs: TestableThumbnailTitleData)-> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.thumbnailURLString == rhs.thumbnailURLString
    }
}
