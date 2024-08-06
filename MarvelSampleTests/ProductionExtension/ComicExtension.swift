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
          descriptionText: String) {
        let dictionary: [String: Any] = [
            "id": "1",
            "pageCount": 123,
            "description": descriptionText,
            "title": title,
            "modified": "2001-01-01T08:46:15-0500",
            "thumbnail": ["path":"http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                          "extension":"jpg"],
            "characters" : [
              "returned" : 0,
              "collectionURI" : "http://gateway.marvel.com/v1/public/comics/82967/characters",
              "items" : [],
              "available" : 0
            ],
            "creators" : [
              "returned" : 1,
              "collectionURI" : "http://gateway.marvel.com/v1/public/comics/82967/creators",
              "items" : [
                [
                  "name" : "Jim Nausedas",
                  "resourceURI" : "http://gateway.marvel.com/v1/public/creators/10021",
                  "role" : "editor"
                ]
              ],
              "available" : 1
            ],
        ]
        let nsDictinary = dictionary as NSDictionary
        self.init(dict: nsDictinary)
    }
}


