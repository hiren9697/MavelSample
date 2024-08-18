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
          description: String) {
        let dictionary: [String: Any] = [
            "id": "1",
            "title": title,
            "description": description,
            "modified": "2001-01-01T08:46:15-0500",
            "thumbnail": ["path":"http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
                          "extension":"jpg"]
        ]
        let nsDictinary = dictionary as NSDictionary
        self.init(dict: nsDictinary)
    }
}
