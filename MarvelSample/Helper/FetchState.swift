//
//  FetchState.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 17/07/24.
//

import Foundation

public enum DataFetchState {
    case initialLoading
    case loadingNextPage
    case idle
    case reload
    case error(Error)
    case emptyData
}

extension DataFetchState: Equatable {
    public static func == (lhs: DataFetchState, rhs: DataFetchState) -> Bool {
            switch (lhs, rhs) {
            case (.initialLoading, .initialLoading):
                return true
            case (.loadingNextPage, .loadingNextPage):
                return true
            case (.idle, .idle):
                return true
            case (.reload, .reload):
                return true
            case (.emptyData, .emptyData):
                return true
            case (.error(_), .error(_)):
                return true
            default:
                return false
            }
        }
}
