//
//  EventItemVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 30/07/24.
//

import UIKit

struct EventItemVM {
    let title: String
    let descriptionText: String
    let thumbnailURL: URL?
    
    init(event: Event) {
        title = event.title
        descriptionText = event.descriptionText
        thumbnailURL = event.thumbnailURL
    }
}
