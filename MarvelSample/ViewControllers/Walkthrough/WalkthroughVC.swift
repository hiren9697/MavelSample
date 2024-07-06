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

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - UI
extension WalkthroughVC {
    
    private func configureUI() {
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
    }
}

// MARK: - Collection Delegate
extension WalkthroughVC: UICollectionViewDelegate {
    
}

// MARK: - Collection Datasource
extension WalkthroughVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WalkthroughCC.name,
                                                      for: indexPath) as! WalkthroughCC
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = .blue
        } else {
            cell.contentView.backgroundColor = .red
        }
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
