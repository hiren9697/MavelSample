//
//  ComicsVC.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 12/07/24.
//

import UIKit

// MARK: - VC
class ComicsVC: ParentVC {
    
    let viewModel: ComicsVM
    
    init(viewModel: ComicsVM = ComicsVM()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialUI()
        showLoader()
        // viewModel.fetchComics()
    }
    
    override func setupInitialUI() {
        super.setupInitialUI()
    }
}

// MARK: - UI Helper
extension ComicsVC {
    
    
}
