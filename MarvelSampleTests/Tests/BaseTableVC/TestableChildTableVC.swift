//
//  TestableChildTableVC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 02/08/24.
//

import UIKit
import Combine
@testable import MarvelSample

/// Subclass of 'BaseTableVC' with filled generics
/// This class is used to test BaseTableVC
/// As subclass of BaseTableVC must override some methods and must fill generics
/// Used in BaseTableVCTests
class TestableChildTableVC: BaseTableVC<TestableAPIDataListable> {
    // MARK: - Closure Variables for tests
    var refreshHandler: (()-> Void)?
    
    // MARK: - Overridden method
    override func fetchInitialData() {
        // Do nothing
    }
    
    // MARK: - Cell methods
    override func registerTableViewDataCell() {
        tableView.register(TestableTableCell.self,
                           forCellReuseIdentifier: TestableTableCell.name)
    }
    
    override func dequeueCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TestableTableCell.name,
                                                 for: indexPath) as! TestableTableCell
        cell.titleLabel.text = viewModel.itemVM(for: indexPath.row).text
        return cell
    }
    
    override func heightForRow(at: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    // MARK: - Overidden methods for tests
    @objc override func handleRefresh() {
        refreshHandler?()
    }
}
