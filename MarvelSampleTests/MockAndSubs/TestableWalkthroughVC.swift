//
//  TestableWalkthroughVC.swift
//  MarvelSampleTests
//
//  Created by Hirenkumar Fadadu on 13/07/24.
//

import UIKit
@testable import MarvelSample

class TestableWalkthroughVC: WalkthroughVC {
    
    var continueButtonClosure: (() -> Void)?
    
    @objc override func continueTap(_ button: UIButton) {
        continueButtonClosure?()
        viewModel.goToNextPage()
    }
    
    override init(viewModel: WalkthroughVM) {
        super.init(viewModel: viewModel)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView = TestableCollectionView(frame: .zero,
                                                     collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
