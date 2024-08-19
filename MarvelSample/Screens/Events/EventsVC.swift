//
//  EventsVC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 12/07/24.
//

import UIKit

/// ViewController for events screen
class EventsVC: BaseTableVC<EventsVM> {
    // MARK: - Cell methods
    override func registerTableViewDataCell() {
        tableView.register(EventItemTC.self, forCellReuseIdentifier: EventItemTC.name)
    }
    
    override func dequeueDataCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventItemTC.name,
                                                 for: indexPath) as! EventItemTC
        cell.updateUI(viewModel: viewModel.itemVM(for: indexPath.row))
        return cell
    }
    
    override func tableViewHeightForDataCell(at indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableViewDidSelectDataCell(at indexPath: IndexPath) {
        // Need to implement this
    }
}
