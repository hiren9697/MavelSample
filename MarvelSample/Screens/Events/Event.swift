//
//  Event.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 30/07/24.
//

import UIKit

struct Event {
    let id: String
    let title: String
    let descriptionText: String
    let modifiedDate: Date?
    let thumbnailURLString: String
    let characterIDs: [String]
    let creatorIDs: [String]
    let comicIDs: [String]
    
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
        // Comics
        guard let comicDict = dict["comics"] as? NSDictionary else {
            return nil
        }
        guard let comicItems = comicDict["items"] as? [NSDictionary] else {
            return nil
        }
        var newComicIDs: [String] = []
        for item in comicItems {
            let urlPath = item.getStringValue(key: "resourceURI")
            guard let url = URL(string: urlPath) else {
                continue
            }
            guard let id = url.pathComponents.last else {
                continue
            }
            newComicIDs.append(id)
        }
        self.comicIDs = newComicIDs
    }
}

extension Event: CustomStringConvertible {
    var description: String {
        return """
               id: \(id),
               title: \(title),
               description: \(descriptionText),
               modified: \(modifiedDateText),
               thumbnail: \(thumbnailURLString),
               creatorIDs: \(creatorIDs),
               characterIDs: \(characterIDs),
               comicIDs: \(comicIDs)
               """
    }
}
