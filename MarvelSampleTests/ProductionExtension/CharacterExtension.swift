//
//  CharacterExtension.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 30/07/24.
//

import Foundation
@testable import MarvelSample

extension Character {
    init?(name: String,
          comicIDs: [String] = [],
          seriesIDs: [String] = []) {
        let dictionary: [String: Any] = [
            "id": "1",
            "name": name,
            "modified": "2001-01-01T08:46:15-0500",
            "thumbnail": ["path":"http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                          "extension":"jpg"],
            "comics": [
                "returned" : comicIDs.count,
                "collectionURI" : "http://gateway.marvel.com/v1/public/characters/1011266/comics",
                "items" : comicIDs.map { NSDictionary(dictionary: ["resourceURI": "http://gateway.marvel.com/v1/public/comics/\($0)"]) },
                "available" : comicIDs.count
            ],
            "series": [
                "returned" : seriesIDs.count,
                "collectionURI" : "http://gateway.marvel.com/v1/public/characters/1011266/series",
                "items" : seriesIDs.map { NSDictionary(dictionary: ["resourceURI": "http://gateway.marvel.com/v1/public/series/\($0)"]) },
                "available" : seriesIDs.count
            ]
        ]
        let nsDictinary = dictionary as NSDictionary
        self.init(dict: nsDictinary)
    }
}
