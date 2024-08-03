//
//  BaseCollectionVC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 18/07/24.
//

import UIKit
import Combine

class BaseCollectionVC<Data,
                       ItemVM,
                       ViewModel: APIDataListable>:
                        ParentVC,
                        UICollectionViewDelegate,
                        UICollectionViewDataSource,
                        UICollectionViewDelegateFlowLayout
where ViewModel.Data == Data,
      ViewModel.ItemVM == ItemVM {
    
    // MARK: UI Components
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        return collectionView
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
        registerCollectionViewDataCell()
        registerCollectionViewOtherCellsAndHeaderFooter()
        setupCollectionView()
        setupBindings()
        fetchInitialData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - UI helper methods
    func setupConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
    }
    
    func registerCollectionViewDataCell() {
        preconditionFailure("Subclass must override this method")
    }
    
    func registerCollectionViewOtherCellsAndHeaderFooter() {
        collectionView.register(EmptyCC.self,
                                forCellWithReuseIdentifier: EmptyCC.name)
        collectionView.register(ErrorCC.self,
                                forCellWithReuseIdentifier: ErrorCC.name)
        collectionView.register(CollectionViewNextPageLoader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: CollectionViewNextPageLoader.name)
        collectionView.register(CollectionViewEmptyFooter.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: CollectionViewEmptyFooter.name)
    }
    
    override func setupInitialUI() {
        super.setupInitialUI()
        // CollectionView
        view.addSubview(collectionView)
        // Loader
        view.bringSubviewToFront(loaderContainer)
        // Refresh Control
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Navigation title
        tabBarController?.title = viewModel.navigationTitle
    }
    
    func fetchInitialData() {
        viewModel.fetchInitialData()
    }
    
    @objc func handleRefresh() {
        viewModel.reloadData()
    }
    
    // MARK: - Binding
    private func setupBindings() {
        viewModel
            .listItems
            .sink(receiveValue: {[weak self] _ in
                gauranteeMainThread {[weak self] in
                    self?.collectionView.reloadData()
                }
            })
            .store(in: &bindings)
        
        viewModel
            .fetchState
            .sink(receiveValue: {[weak self] state in
                gauranteeMainThread {[weak self] in
                    switch state {
                    case .idle:
                        self?.refreshControl.endRefreshing()
                        self?.hideLoader()
                    case .initialLoading:
                        self?.showLoader()
                        self?.refreshControl.endRefreshing()
                    case .loadingNextPage:
                        self?.hideLoader()
                        self?.refreshControl.endRefreshing()
                        break
                    case .reload:
                        self?.hideLoader()
                        break
                    case .error(_):
                        self?.hideLoader()
                        self?.refreshControl.endRefreshing()
                        break
                    case .emptyData:
                        self?.hideLoader()
                        self?.refreshControl.endRefreshing()
                        break
                    }
                    self?.collectionView.reloadData()
                }
            })
            .store(in: &bindings)
    }
    
    // MARK: - Datasource Helper
    func dequeueCell(at indexPath: IndexPath)-> UICollectionViewCell {
        preconditionFailure("Subclass must override this method")
    }
    
    func dequeueEmptyDataCell(at indexPath: IndexPath)-> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCC.name,
                                                      for: indexPath) as! EmptyCC
        cell.titleLabel.text = "Couldn't find any Comic"
        return cell
    }
    
    func dequeueErrorCell(at indexPath: IndexPath)-> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ErrorCC.name,
                                                      for: indexPath) as! ErrorCC
        cell.titleLabel.text = "Error in fetching Comics"
        return cell
    }
    
    func deququeEmptyFooterView(indexPath: IndexPath)-> UICollectionReusableView {
        collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                               withReuseIdentifier: CollectionViewEmptyFooter.name,
                                                               for: indexPath) as! CollectionViewEmptyFooter
    }
    
    func dequeueNextPageLoadingFooterView(indexPath: IndexPath)-> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                   withReuseIdentifier: CollectionViewNextPageLoader.name,
                                                                   for: indexPath) as! CollectionViewNextPageLoader
        view.activity.startAnimating()
        return view
    }
    
    // MARK: - CollectionView Datasource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch viewModel.fetchState.value {
        case .initialLoading:
            return 0
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.fetchState.value {
        case .initialLoading:
            return 0
        case .loadingNextPage, .idle, .reload:
            return viewModel.listItems.value.count
        case .emptyData, .error(_):
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.fetchState.value {
        case .initialLoading:
            return UICollectionViewCell()
        case .loadingNextPage, .idle, .reload:
            let cell = dequeueCell(at: indexPath)
            return cell
        case .error(_):
            return dequeueErrorCell(at: indexPath)
        case .emptyData:
            return dequeueEmptyDataCell(at: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch viewModel.fetchState.value {
        case .initialLoading, .error(_), .emptyData, .idle, .reload:
            return .zero
        case .loadingNextPage:
            return CGSize(width: collectionView.bounds.width,
                          height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch viewModel.fetchState.value {
        case .initialLoading, .error(_), .emptyData, .idle, .reload:
            return deququeEmptyFooterView(indexPath: indexPath)
        case .loadingNextPage:
            return dequeueNextPageLoadingFooterView(indexPath: indexPath)
        }
    }
    
    // MARK: - Delegate helper
    func collectionViewDidSelect(indexPath: IndexPath) {
       fatalError("Subclass must override this method")
    }
    
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       collectionViewDidSelect(indexPath: indexPath)
    }
    
    // MARK: - FlowLayout Helper
    func collectionViewMinimumInterItemSpacingFor(section: Int)-> CGFloat {
        preconditionFailure("Subclass must override this method")
    }
    
    func collectionViewMinimumLineSpacingFor(section: Int)-> CGFloat {
        preconditionFailure("Subclass must override this method")
    }
    
    func collectionViewInsetsFor(section: Int)-> UIEdgeInsets {
        preconditionFailure("Subclass must override this method")
    }
    
    func collectionViewSizeForItem(at indexPath: IndexPath) -> CGSize {
        preconditionFailure("Subclass must override this method")
    }
    
    // MARK: - CollectionView FlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch viewModel.fetchState.value {
        case .initialLoading, .error(_), .emptyData:
            return .leastNonzeroMagnitude
        case .loadingNextPage, .idle, .reload:
            return collectionViewMinimumInterItemSpacingFor(section: section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch viewModel.fetchState.value {
        case .initialLoading, .error(_), .emptyData:
            return .leastNonzeroMagnitude
        case .loadingNextPage, .idle, .reload:
            return collectionViewMinimumLineSpacingFor(section: section)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        collectionViewInsetsFor(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.fetchState.value {
        case .initialLoading:
            return .zero
        case .error(_), .emptyData:
            return CGSize(width: 250, height: 300)
        case .loadingNextPage, .idle, .reload:
            return collectionViewSizeForItem(at: indexPath)
        }
    }
}
