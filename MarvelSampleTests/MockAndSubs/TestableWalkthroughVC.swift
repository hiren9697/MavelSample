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
}
