//
//  Helpers.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 10/07/24.
//

import UIKit

func numberOfSections(in tableView: UITableView)-> Int? {
    tableView
        .dataSource?
        .numberOfSections?(in: tableView)
}

func numberOfRows(in tableView: UITableView,
                  section: Int = 0)-> Int? {
    tableView
        .dataSource?
        .tableView(tableView,
                   numberOfRowsInSection: section)
}

func cellForRow(in tableView: UITableView,
                row: Int,
                section: Int = 0) -> UITableViewCell? {
    tableView
        .dataSource?
        .tableView(tableView,
                   cellForRowAt: IndexPath(row: row, section: section))
}

func didSelectRow(in tableView: UITableView,
                  row: Int,
                  section: Int = 0) {
    tableView
        .delegate?
        .tableView?(tableView,
                     didSelectRowAt: IndexPath(row: row, section: section))
}

func footerViewHeight(in tableView: UITableView, section: Int = 0)-> CGFloat? {
    let height = tableView.delegate?.tableView?(tableView, heightForFooterInSection: section)
    return height
}

func footer(in tableView: UITableView,
            section: Int = 0)-> UIView? {
    let footer = tableView
        .delegate?
        .tableView?(tableView, viewForFooterInSection: section)
    return footer
}
