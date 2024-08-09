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
    let characterIDs: [String]
    let creatorIDs: [String]
    
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
        // Thumbnail
        guard let thumbnailDict = dict["thumbnail"] as? NSDictionary else {
            return nil
        }
        let thumbnailPath = thumbnailDict.getStringValue(key: "path")
        let thumbnailExtension = thumbnailDict.getStringValue(key: "extension")
        thumbnailURLString = thumbnailPath + "." + thumbnailExtension
        // Characters
        guard let characterDict = dict["characters"] as? NSDictionary else {
            return nil
        }
        guard let characterItems = characterDict["items"] as? [NSDictionary] else {
            return nil
        }
        var newCharacterIDs: [String] = []
        for item in characterItems {
            let urlPath = item.getStringValue(key: "resourceURI")
            guard let url = URL(string: urlPath) else {
                continue
            }
            guard let id = url.pathComponents.last else {
                continue
            }
            newCharacterIDs.append(id)
        }
        self.characterIDs = newCharacterIDs
        // Creators
        guard let creatorDict = dict["creators"] as? NSDictionary else {
            return nil
        }
        guard let creatorItems = creatorDict["items"] as? [NSDictionary] else {
            return nil
        }
        var newCreatorIDs: [String] = []
        for item in creatorItems {
            let urlPath = item.getStringValue(key: "resourceURI")
            guard let url = URL(string: urlPath) else {
                continue
            }
            guard let id = url.pathComponents.last else {
                continue
            }
            newCreatorIDs.append(id)
        }
        self.creatorIDs = newCreatorIDs
        // Other
        id = dict.getStringValue(key: "id")
        pages = dict.getIntValue(key: "pageCount")
        descriptionText = dict.getStringValue(key: "description")
        title = dict.getStringValue(key: "title")
        // Date
        let dateText = dict.getStringValue(key: "modified")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        modifiedDate = dateFormatter.date(from: dateText)
    }
}

extension Comic: CustomStringConvertible {
    
    var description: String {
        return """
               id: \(id),
               title: \(title),
               description: \(descriptionText),
               pages: \(pages),
               modified: \(modifiedDateText),
               thumbnail: \(thumbnailURLString)
               characterIDs: \(characterIDs)
               """
    }
}
