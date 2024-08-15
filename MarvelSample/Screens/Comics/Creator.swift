//
//  Creator.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 10/08/24.
//

import Foundation

struct Creator {
    let id: String
    let fullName: String
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
        fullName = dict.getStringValue(key: "fullName")
    }
}

extension Creator: CustomStringConvertible {
    
    var description: String {
        return """
               id: \(id),
               fullName: \(fullName),
               thumbnail: \(thumbnailURLString)
               """
    }
}

extension Creator: Equatable {
    static func == (lhs: Creator, rhs: Creator) -> Bool {
        lhs.id == rhs.id &&
        lhs.fullName == rhs.fullName &&
        lhs.thumbnailURLString == rhs.thumbnailURLString
    }
}
