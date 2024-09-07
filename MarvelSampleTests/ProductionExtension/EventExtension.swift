//
//  EventExtension.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 18/08/24.
//

import Foundation
@testable import MarvelSample

extension Event {
    init?(title: String,
          description: String,
          characterIDs: [String] = [],
          creatorIDs: [String] = [],
          comicIDs: [String] = []) {
        let dictionary: [String: Any] = [
            "id": "1",
            "title": title,
            "description": description,
            "modified": "2001-01-01T08:46:15-0500",
            "thumbnail": ["path":"http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                          "extension":"jpg"],
            "characters" : [
                "returned" : characterIDs.count,
                "collectionURI" : "http://gateway.marvel.com/v1/public/comics/82967/characters",
                "items" : characterIDs.map { NSDictionary(dictionary: ["resourceURI": "http://gateway.marvel.com/v1/public/characters/\($0)"]) },
                "available" : characterIDs.count
            ],
            "creators" : [
                "returned" : creatorIDs.count,
                "collectionURI" : "http://gateway.marvel.com/v1/public/comics/82967/creators",
                "items" : characterIDs.map { NSDictionary(dictionary: ["resourceURI": "http://gateway.marvel.com/v1/public/creators/\($0)"]) },
                "available" : creatorIDs.count
            ],
            "comics": [
                "returned" : comicIDs.count,
                "collectionURI" : "http://gateway.marvel.com/v1/public/characters/1011266/comics",
                "items" : comicIDs.map { NSDictionary(dictionary: ["resourceURI": "http://gateway.marvel.com/v1/public/comics/\($0)"]) },
                "available" : comicIDs.count
            ],
        ]
        let nsDictinary = dictionary as NSDictionary
        self.init(dict: nsDictinary)
    }
}
