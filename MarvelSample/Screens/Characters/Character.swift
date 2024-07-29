//
//  Character.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 29/07/24.
//

import Foundation

struct Character {
    let id: String
    let name: String
    let modifiedDate: Date?
    let thumbnailURLString: String
    
    var modifiedDateText: String {
        guard let modifiedDate = modifiedDate else {
            return "-"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: modifiedDate)
    }
    var thumbnailURL: URL? {
        URL(string: thumbnailURLString)
    }
    
    init?(dict: NSDictionary) {
        id = dict.getStringValue(key: "id")
        name = dict.getStringValue(key: "name")
        // Date
        let dateText = dict.getStringValue(key: "modified")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        modifiedDate = dateFormatter.date(from: dateText)
        // Thumbnail
        guard let thumbnailDict = dict["thumbnail"] as? NSDictionary else {
            return nil
        }
        let thumbnailPath = thumbnailDict.getStringValue(key: "path")
        let thumbnailExtension = thumbnailDict.getStringValue(key: "extension")
        thumbnailURLString = thumbnailPath + "." + thumbnailExtension
        
    }
}

extension Character: CustomStringConvertible {
    
    var description: String {
        return """
               id: \(id),
               name: \(name),
               modified: \(modifiedDateText),
               thumbnail: \(thumbnailURLString)
               """
    }
    
//    init(id: String,
//         name: String,
//         modifiedDate: Date?,
//         thumbnailURLString: String) {
//        self.id = id
//        self.name = name
//        self.modifiedDate = modifiedDate
//        self.thumbnailURLString = thumbnailURLString
//    }
}

