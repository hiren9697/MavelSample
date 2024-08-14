//
//  APIDataListable.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 19/07/24.
//

import Foundation
import Combine

protocol APIDataListable {
    associatedtype Data // Data
    associatedtype ItemVM // ListItem
    var navigationTitle: String? { get }
    var fetchState: CurrentValueSubject<DataFetchState, Never> { get set }
    var data: Array<Data> { get set }
    var listItems: CurrentValueSubject<Array<ItemVM>, Never> { get set }
    
    func fetchInitialData()
    func reloadData()
    func itemVM(for: Int) -> ItemVM
}
