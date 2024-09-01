//
//  CharactersVCSnapshotTests.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 24/08/24.
//

import XCTest
import SnapshotTesting
@testable import MarvelSample

final class CharactersVCSnapshotTests: XCTestCase {
    var sut: TestableCharactersVC!
    var viewModel: TestableCharactersVM!
    
    override func setUp() {
        super.setUp()
        viewModel = TestableCharactersVM()
        sut = TestableCharactersVC(viewModel: viewModel)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }
}

// MARK: - Tests
extension CharactersVCSnapshotTests {
    func test_UIWithFetchState_initialLoading() {
        viewModel.fetchState.value = .initialLoading
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_charactersVC_withFetchState_initialLoading")
    }
    
    func test_UIWithFetchState_emptyData() {
        viewModel.fetchState.value = .emptyData
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_charactersVC_withFetchState_emptyData")
    }
    
    func test_UIWithFetchState_error() {
        viewModel.fetchState.value = .error(DummyNetworkError.somethingWentWrong)
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_charactersVC_withFetchState_error")
    }
    
    func test_UIWithFetchState_idle() {
        addListItemsWithIdleModeInViewModel()
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_charactersVC_withFetchState_idle")
    }
    
    func test_UIWithFetchState_nextPageLoading() {
        addListItemsWithIdleModeInViewModel()
        viewModel.fetchState.value = .loadingNextPage
        assertSnapshot(matching: sut, as: .image, record: false, testName: "test_charactersVC_withFetchState_loadingNextPage")
    }
}

// MARK: - Helper
extension CharactersVCSnapshotTests {
    private func addListItemsWithIdleModeInViewModel() {
        viewModel.fetchState.value = .idle
        viewModel.listItems.value = [
            CharacterItemVM(character: Character(name: "Zeroth character name")!),
            CharacterItemVM(character: Character(name: "First character name")!),
            CharacterItemVM(character: Character(name: "Second character name")!),
            CharacterItemVM(character: Character(name: "Third character name")!),
        ]
    }
}
