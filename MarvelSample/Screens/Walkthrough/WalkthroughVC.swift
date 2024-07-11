//
//  WalkthroughVC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import UIKit	
import Combine

// MARK: - VC
class WalkthroughVC: UIViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WalkthroughCC.self,
                                forCellWithReuseIdentifier: WalkthroughCC.name)
        return collectionView
    }()
    let continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = AppColors.red
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .white
        pageControl.currentPageIndicatorTintColor = AppColors.red
        return pageControl
    }()
    var currentItem: Int? {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
        return visibleIndexPath?.row
    }
    
    private let viewModel: WalkthroughVM
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: WalkthroughVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        Log.create("Initialized: \(String(describing: self))")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        Log.destroy("Deinitialized: \(String(describing: self))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupBindings()
    }
}

// MARK: - Bindings
extension WalkthroughVC {
    
    private func setupBindings() {
        viewModel
            .currentPage
            .sink {[weak self] value in
                guard let strongSelf = self else {
                    return
                }
                // Update collection view
                if strongSelf.currentItem != value {
                    strongSelf.collectionView.scrollToItem(at: IndexPath(row: value,
                                                              section: 0),
                                                at: .centeredHorizontally,
                                                animated: true)
                }
                // Update page control
                strongSelf.pageControl.currentPage = value
                // Update button title
                strongSelf.continueButton.setTitle(strongSelf.viewModel.buttonTitle, for: .normal)
                Log.info("Current page: \(value), title: \(strongSelf.viewModel.buttonTitle)")
            }
            .store(in: &bindings)
    }
}

// MARK: - UI
extension WalkthroughVC {
    
    private func configureUI() {
        view.backgroundColor = .black
        collectionView.backgroundColor = .black
        // 1. CollectionView
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        // 2. Continue Button
        continueButton.addTarget(self, action: #selector(continueTap), for: .touchUpInside)
        view.addSubview(continueButton)
        continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: 30).isActive = true
        continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -30).isActive = true
        continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                               constant: -80).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // 3. Page control
        pageControl.numberOfPages = viewModel.items.count
        view.addSubview(pageControl)
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.bottomAnchor.constraint(equalTo: continueButton.topAnchor,
                                            constant: -20).isActive = true
    }
}

// MARK: - Actions
extension WalkthroughVC {
    
    @objc func continueTap(_ button: UIButton) {
        viewModel.goToNextPage()
    }
}

// MARK: - Collection Delegate
extension WalkthroughVC: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let currentItem = currentItem,
           currentItem != viewModel.currentPage.value {
            viewModel.currentPage.value = currentItem
            Log.info("Current page updated: \(currentItem)")
        }
    }
}

// MARK: - Collection Datasource
extension WalkthroughVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WalkthroughCC.name,
                                                      for: indexPath) as! WalkthroughCC
        let itemViewModel = viewModel.items[indexPath.row]
        cell.updateUI(viewModel: itemViewModel)
        return cell
    }
}

// MARK: - Collection DelegateFlowLayout
extension WalkthroughVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width, height: view.bounds.height)
    }
}
