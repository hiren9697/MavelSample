//
//  TabBarVM.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 14/07/24.
//

import UIKit

struct TabBarVM {
    let comicsTabItemVM = TabBarItemVM(title: "Comics",
                                       image: UIImage(systemName: "book")!,
                                       selectedImage: UIImage(systemName: "book.fill")!)
    let charactersTabItemVM = TabBarItemVM(title: "Characters",
                                       image: UIImage(systemName: "person")!,
                                       selectedImage: UIImage(systemName: "person.fill")!)
    let eventsTabItemVM = TabBarItemVM(title: "Events",
                                       image: UIImage(systemName: "person.3.sequence")!,
                                       selectedImage: UIImage(systemName: "person.3.sequence.fill")!)
}
