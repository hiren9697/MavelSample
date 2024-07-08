//
//  WalkthroughVC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 06/07/24.
//

import UIKit	

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
    
    let viewModel = WalkthroughVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
        
    }
}

// MARK: - Collection Delegate
extension WalkthroughVC: UICollectionViewDelegate {
    
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
