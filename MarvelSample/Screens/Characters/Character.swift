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
    let comicIDs: [String]
    let seriesIDs: [String]
    let storyIDs: [String]
    
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
        // Series
        guard let seriesDict = dict["series"] as? NSDictionary else {
            return nil
        }
        guard let seriesItems = seriesDict["items"] as? [NSDictionary] else {
            return nil
        }
        var newSeriesIDs: [String] = []
        for item in seriesItems {
            let urlPath = item.getStringValue(key: "resourceURI")
            guard let url = URL(string: urlPath) else {
                continue
            }
            guard let id = url.pathComponents.last else {
                continue
            }
            newSeriesIDs.append(id)
        }
        self.seriesIDs = newSeriesIDs
        // Stories
        guard let storiesDict = dict["stories"] as? NSDictionary else {
            return nil
        }
        guard let storyItems = storiesDict["items"] as? [NSDictionary] else {
            return nil
        }
        var newStoryIDs: [String] = []
        for item in storyItems {
            let urlPath = item.getStringValue(key: "resourceURI")
            guard let url = URL(string: urlPath) else {
                continue
            }
            guard let id = url.pathComponents.last else {
                continue
            }
            newStoryIDs.append(id)
        }
        self.storyIDs = newStoryIDs
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
}

extension Character: Equatable {
    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.modifiedDate == rhs.modifiedDate &&
        lhs.thumbnailURLString == rhs.thumbnailURLString
    }
}

