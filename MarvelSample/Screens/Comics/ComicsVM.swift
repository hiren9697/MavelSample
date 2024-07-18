//
//  ComicsVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 14/07/24.
//

import UIKit
import Combine

class ComicsVM: BaseListViewModel<Comic, ComicItemVM> {
    
    override var emptyDataTitle: String {
        "Couldn't find any comic"
    }
    override var errorTitle: String {
       "Error in fetching comics" 
    }
    
    override func parseData(json: Any) {
        guard let dict = json as? NSDictionary else {
            return
        }
        guard let data = dict["data"] as? NSDictionary else {
            return
        }
        guard let results = data["results"] as? [NSDictionary] else {
            return
        }
        var newComics: [Comic] = []
        var newComicItems: [ComicItemVM] = []
        for item in results {
            if let comic = Comic(dict: item) {
                newComics.append(comic)
                newComicItems.append(ComicItemVM(comic: comic))
            }
        }
        self.data.append(contentsOf: newComics)
        listItems.value.append(contentsOf: newComicItems)
    }
}
