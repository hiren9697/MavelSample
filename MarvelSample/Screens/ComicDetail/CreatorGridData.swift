//
//  CreatorGridData.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 10/08/24.
//

import Foundation

final class CreatorGridData: HorizontalGridData {
    let title: String
    var data: [CDCreatorItemVM]
    
    init(title: String = "Creators",
         data: [CDCreatorItemVM]) {
        self.title = title
        self.data = data
    }
}
