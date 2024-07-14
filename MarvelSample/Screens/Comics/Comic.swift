//
//  Comic.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 14/07/24.
//

import Foundation

struct Comic {
    let id: String
    let pages: Int
    let descriptionText: String
    let title: String
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
        pages = dict.getIntValue(key: "pageCount")
        descriptionText = dict.getStringValue(key: "description")
        title = dict.getStringValue(key: "title")
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

extension Comic: CustomStringConvertible {
    
    var description: String {
        return """
               id: \(id),
               title: \(title),
               description: \(descriptionText),
               modified: \(modifiedDateText),
               thumbnail: \(thumbnailURLString)
               """
    }
}
