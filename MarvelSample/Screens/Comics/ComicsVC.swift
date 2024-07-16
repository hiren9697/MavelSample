//
//  ComicsVC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 12/07/24.
//

import UIKit
import Combine

// MARK: - VC
class ComicsVC: ParentVC {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    let itemSpace: CGFloat = 10
    let lineSpace: CGFloat = 10
    let padding: CGFloat = 20
    lazy var itemSize: CGSize = {
        let extraWidth = itemSpace + (padding * 2)
        let remainingWidth = view.bounds.width - extraWidth
        let finalWidth = remainingWidth / 2
        let height = finalWidth * 1.4
        return CGSize(width: finalWidth, height: height)
    }()
    let invalidDataItemSize: CGSize = CGSize(width: 250, height: 300)
    
    private let viewModel: ComicsVM
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: ComicsVM = ComicsVM()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.fetchComics()
        // showLoader()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func setupInitialUI() {
        super.setupInitialUI()
        
        // CollectionView
        view.addSubview(collectionView)
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.register(ComicItemCC.self,
                                forCellWithReuseIdentifier: ComicItemCC.name)
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        
        // Loader
        view.bringSubviewToFront(loaderContainer)
    }
}

// MARK: - UI Helper
extension ComicsVC {
    
}

// MARK: - Bindings
extension ComicsVC {
   
    private func setupBindings() {
        viewModel
            .comicItems
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] _ in
                self?.collectionView.reloadData()
            })
            .store(in: &bindings)
        
        viewModel
            .fetchState
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] state in
                switch state {
                case .idle:
                    self?.hideLoader()
                case .initialLoading:
                    self?.showLoader()
                case .loadingNextPage:
                    self?.hideLoader()
                    break
                case .error(_):
                    self?.hideLoader()
                    self?.collectionView.reloadData()
                    break
                case .emptyData:
                    self?.hideLoader()
                    self?.collectionView.reloadData()
                    break
                }
            })
            .store(in: &bindings)
    }
}

// MARK: - Delegate
extension ComicsVC: UICollectionViewDelegate {
    
}

// MARK: - DataSource
extension ComicsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch viewModel.fetchState.value {
        case .initialLoading:
            return 0
        case .loadingNextPage, .idle:
            return viewModel.comicItems.value.count
        case .emptyData, .error(_):
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.fetchState.value {
        case .initialLoading:
            return UICollectionViewCell()
        case .loadingNextPage, .idle:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicItemCC.name,
                                                          for: indexPath) as! ComicItemCC
            cell.updateUI(viewModel: viewModel.itemVM(for: indexPath.row))
            return cell
        case .error(_):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ErrorCC.name,
                                                          for: indexPath) as! ErrorCC
            cell.titleLabel.text = "Error in fetching Comics"
            return cell
        case .emptyData:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyCC.name,
                                                          for: indexPath) as! EmptyCC
            cell.titleLabel.text = "Couldn't find any Comic"
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch viewModel.fetchState.value {
        case .initialLoading, .error(_), .emptyData:
            return .zero
        case .loadingNextPage, .idle:
            return CGSize(width: collectionView.bounds.width,
                      height: 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch viewModel.fetchState.value {
        case .initialLoading, .error(_), .emptyData, .idle:
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                   withReuseIdentifier: CollectionViewEmptyFooter.name,
                                                                   for: indexPath) as! CollectionViewEmptyFooter
        case .loadingNextPage:
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                       withReuseIdentifier: CollectionViewNextPageLoader.name,
                                                                       for: indexPath) as! CollectionViewNextPageLoader
            view.activity.startAnimating()
            return view
        }
    }
}

// MARK: - Delegate FlowLayout
extension ComicsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch viewModel.fetchState.value {
        case .initialLoading, .error(_), .emptyData:
            return .leastNonzeroMagnitude
        case .loadingNextPage, .idle:
            return itemSpace
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch viewModel.fetchState.value {
        case .initialLoading, .error(_), .emptyData:
            return .leastNonzeroMagnitude
        case .loadingNextPage, .idle:
            return lineSpace
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.fetchState.value {
        case .initialLoading:
            return .zero
        case .error(_), .emptyData:
            return invalidDataItemSize
        case .loadingNextPage, .idle:
            return itemSize
        }
        
    }
}
