//
//  CharactersGridData.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 10/08/24.
//

import Foundation

final class CharactersGridVM: HorizontalThumbnailTitleGridViewModel {
    let title: String
    var data: [CDCharacterItemVM]
    
    init(title: String = "Characters",
         data: [CDCharacterItemVM]) {
        self.title = title
        self.data = data
    }
}
