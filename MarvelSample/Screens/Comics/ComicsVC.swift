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
        // showLoader()
        setupBindings()
        viewModel.fetchComics()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // collectionView.reloadData()
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
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
    }
}

// MARK: - Delegate
extension ComicsVC: UICollectionViewDelegate {
    
}

// MARK: - DataSource
extension ComicsVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.comicItems.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicItemCC.name,
                                                      for: indexPath) as! ComicItemCC
        cell.updateUI(viewModel: viewModel.comicItems.value[indexPath.row])
        return cell
    }
}

// MARK: - Delegate FlowLayout
extension ComicsVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        itemSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        lineSpace
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        itemSize
    }
}
