//
//  BaseTableVC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 31/07/24.
//

import UIKit
import Combine

class BaseTableVC<ViewModel: APIDataListable>: ParentVC, UITableViewDelegate, UITableViewDataSource {
    // MARK: - UI Components
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = AppColors.red
        return refreshControl
    }()
    
    // MARK: - Variables
    let viewModel: ViewModel
    private var bindings = Set<AnyCancellable>()
    
    // MARK: - Life cycle
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialUI()
        setupConstraints()
        registerTableViewDataCell()
        registerTableViewOtherCellsAndHeaderFooter()
        setupCollectionView()
        setupBindings()
        fetchInitialData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - UI helper methods
    func setupConstraints() {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupCollectionView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.reloadData()
    }
    
    func registerTableViewDataCell() {
        preconditionFailure("Subclass must override this method")
    }
    
    func registerTableViewOtherCellsAndHeaderFooter() {
        tableView.register(EmptyTC.self,
                           forCellReuseIdentifier: EmptyTC.name)
        tableView.register(ErrorTC.self,
                           forCellReuseIdentifier: ErrorTC.name)
        tableView.register(TableViewNextPageLoader.self,
                           forHeaderFooterViewReuseIdentifier: TableViewNextPageLoader.name)
    }
    
    override func setupInitialUI() {
        super.setupInitialUI()
        // CollectionView
        view.addSubview(tableView)
        // Loader
        view.bringSubviewToFront(loaderContainer)
        // Refresh Control
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    func fetchInitialData() {
        viewModel.fetchInitialData()
    }
    
    @objc func handleRefresh() {
        viewModel.reloadData()
    }
    
    private func hideLoadingComponents() {
        refreshControl.endRefreshing()
        hideLoader()
        stopNextPageLoaderAnimating()
    }
    
    private func stopNextPageLoaderAnimating() {
        let nextPageLoader = getNextPageLoadingFooterView()
        nextPageLoader.stopAnimating()
    }
    
    // MARK: - Binding
    private func setupBindings() {
        viewModel
            .listItems
            .sink(receiveValue: {[weak self] _ in
                gauranteeMainThread {[weak self] in
                    self?.tableView.reloadData()
                }
            })
            .store(in: &bindings)
        
        viewModel
            .fetchState
            .sink(receiveValue: {[weak self] state in
                gauranteeMainThread {[weak self] in
                    switch state {
                    case .idle:
                        self?.hideLoadingComponents()
                    case .initialLoading:
                        self?.showLoader()
                        self?.refreshControl.endRefreshing()
                        self?.stopNextPageLoaderAnimating()
                    case .loadingNextPage:
                        self?.hideLoader()
                        self?.refreshControl.endRefreshing()
                        break
                    case .reload:
                        self?.hideLoader()
                        self?.stopNextPageLoaderAnimating()
                        break
                    case .error(_):
                        self?.hideLoadingComponents()
                        break
                    case .emptyData:
                        self?.hideLoadingComponents()
                        break
                    }
                    self?.tableView.reloadData()
                }
            })
            .store(in: &bindings)
    }
    
    // MARK: - Datasource Helper
    func dequeueCell(at indexPath: IndexPath)-> UITableViewCell {
        preconditionFailure("Subclass must override this method")
    }
    
    func dequeueEmptyDataCell(at indexPath: IndexPath)-> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTC.name,
                                                      for: indexPath) as! EmptyTC
        cell.titleLabel.text = "Couldn't find any Comic"
        return cell
    }
    
    func dequeueErrorCell(at indexPath: IndexPath)-> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ErrorTC.name,
                                                      for: indexPath) as! ErrorTC
        cell.titleLabel.text = "Error in fetching Comics"
        return cell
    }
    
    func getNextPageLoadingFooterView()-> TableViewNextPageLoader {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableViewNextPageLoader") as! TableViewNextPageLoader
    }
    
    // MARK: - TableView Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        switch viewModel.fetchState.value {
        case .initialLoading:
            return 0
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.fetchState.value {
        case .initialLoading:
            return 0
        case .loadingNextPage, .idle, .reload:
            return viewModel.listItems.value.count
        case .emptyData, .error(_):
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.fetchState.value {
        case .initialLoading:
            return UITableViewCell()
        case .loadingNextPage, .idle, .reload:
            let cell = dequeueCell(at: indexPath)
            return cell
        case .error(_):
            return dequeueErrorCell(at: indexPath)
        case .emptyData:
            return dequeueEmptyDataCell(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch viewModel.fetchState.value {
        case .initialLoading, .error(_), .emptyData, .idle, .reload:
            return 0
        case .loadingNextPage:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch viewModel.fetchState.value {
        case .initialLoading, .error(_), .emptyData, .idle, .reload:
            return nil
        case .loadingNextPage:
            let view = getNextPageLoadingFooterView()
            view.startAnimating()
            return view
        }
    }
    
    // MARK: - TableView Delegate Helper
    func heightForRow(at: IndexPath)-> CGFloat {
        fatalError("Sub-class must override this")
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
