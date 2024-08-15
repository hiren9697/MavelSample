//
//  CharactersGridData.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 10/08/24.
//

import Foundation

final class CharactersGridVM: HorizontalThumbnailTitleGridViewModel {
    let title: String
    let emptyDataTitle: String
    var data: [CDCharacterItemVM]
    
    init(title: String = "Characters",
         emptyDataTitle: String = "Couln't found any character",
         data: [CDCharacterItemVM]) {
        self.title = title
        self.emptyDataTitle = emptyDataTitle
        self.data = data
    }
}

extension CharactersGridVM: Equatable {
    static func == (lhs: CharactersGridVM, rhs: CharactersGridVM) -> Bool {
        lhs.title == rhs.title &&
        lhs.emptyDataTitle == rhs.emptyDataTitle &&
        lhs.data == rhs.data
    }
}
