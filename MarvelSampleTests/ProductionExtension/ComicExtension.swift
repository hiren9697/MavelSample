//
//  ComicExtension.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 21/07/24.
//

import Foundation
@testable import MarvelSample

extension Comic {
    init?(title: String,
          descriptionText: String,
          characterIDs: [String] = [],
          creatorIDs: [String] = []) {
        let dictionary: [String: Any] = [
            "id": "1",
            "pageCount": 123,
            "description": descriptionText,
            "title": title,
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
        ]
        let nsDictinary = dictionary as NSDictionary
        self.init(dict: nsDictinary)
    }
}


