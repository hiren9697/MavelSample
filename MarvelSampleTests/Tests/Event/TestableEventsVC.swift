//
//  TestableEventsVC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 02/08/24.
//

import UIKit
@testable import MarvelSample

/// A subclass of EventsVC written to prevent API call automatically when view loads and prevent image loading
/// This class is used in unit tests whereever a EventsVC expected
/// If we uses actual EventsVC, actual API call will be called every-time a object of EventsVC created and image loading will be attempted many times
class TestableEventsVC: EventsVC {
    override func fetchInitialData() {
        // Do nothing
    }
    
    override func registerTableViewDataCell() {
        tableView.register(TestableEventItemTC.self, forCellReuseIdentifier: TestableEventItemTC.name)
    }
    
    override func dequeueDataCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TestableEventItemTC.name,
                                                 for: indexPath) as! TestableEventItemTC
        cell.updateUI(viewModel: viewModel.itemVM(for: indexPath.row))
        return cell
    }
}
