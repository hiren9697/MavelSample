//
//  PaginationManager.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 17/07/24.
//

import Foundation

class PaginationManager {
    let limit: Int
    var offset: Int = 0
    var total: Int? = nil
    var hasMore: Bool {
        guard let total = total else {
            return true
        }
        return offset < total
    }
    
    init(limit: Int = 10) {
        self.limit = limit
    }
    
    func reload() {
        offset = 0
    }
}
