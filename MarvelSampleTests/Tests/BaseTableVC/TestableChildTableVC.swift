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
/// This class is used to test BaseTableVC, in BaseTableVCTests
/// As subclass of BaseTableVC must override some methods and must fill generics
class TestableChildTableVC: BaseTableVC<TestableAPIDataListable> {
    // MARK: - Cell methods
    override func registerTableViewDataCell() {
        tableView.register(TestableTableCell.self,
                           forCellReuseIdentifier: TestableTableCell.name)
    }
    
    override func dequeueDataCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TestableTableCell.name,
                                                 for: indexPath) as! TestableTableCell
        cell.titleLabel.text = viewModel.itemVM(for: indexPath.row).text
        return cell
    }
    
    override func tableViewHeightForDataCell(at indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableViewDidSelectDataCell(at indexPath: IndexPath) {
        // Do nothing
    }
}
