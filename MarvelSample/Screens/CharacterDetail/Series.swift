//
//  Series.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 02/09/24.
//

import Foundation

struct Series {
    let id: String
    let title: String
    let thumbnailURLString: String
    var thumbnailURL: URL? {
        URL(string: thumbnailURLString)
    }
    
    init?(dict: NSDictionary) {
        // Thumbnail
        guard let thumbnailDict = dict["thumbnail"] as? NSDictionary else {
            return nil
        }
        let thumbnailPath = thumbnailDict.getStringValue(key: "path")
        let thumbnailExtension = thumbnailDict.getStringValue(key: "extension")
        thumbnailURLString = thumbnailPath + "." + thumbnailExtension
        // Other
        id = dict.getStringValue(key: "id")
        title = dict.getStringValue(key: "title")
    }
}

extension Series: CustomStringConvertible {
    var description: String {
        return """
               id: \(id),
               title: \(title),
               thumbnail: \(thumbnailURLString)
               """
    }
}

extension Series: Equatable {
    static func == (lhs: Series, rhs: Series) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.thumbnailURLString == rhs.thumbnailURLString
    }
}
