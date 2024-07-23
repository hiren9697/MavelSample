//
//  TestableComicsVM.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 23/07/24.
//

import Foundation
@testable import MarvelSample

class TestableComicsVM: ComicsVM {
    
    override func itemVM(for row: Int) -> ComicItemVM {
        return listItems.value[row]
    }
}
