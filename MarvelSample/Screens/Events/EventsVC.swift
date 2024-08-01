//
//  EventsVC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 12/07/24.
//

import UIKit

class EventsVC: BaseTableVC<EventsVM> {
    
    // MARK: - Cell methods
    override func registerTableViewDataCell() {
        tableView.register(EventItemTC.self, forCellReuseIdentifier: EventItemTC.name)
    }
    
    override func dequeueCell(at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventItemTC.name,
                                                 for: indexPath) as! EventItemTC
        cell.updateUI(viewModel: viewModel.itemVM(for: indexPath.row))
        return cell
    }
    
    override func heightForRow(at: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
