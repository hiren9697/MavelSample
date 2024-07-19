//
//  TabBarController.swift
//  MarvelSample
//
//  Created by Hirenkumar Fadadu on 12/07/24.
//

import UIKit

// MARK: - VC
class TabBarController: UITabBarController {
    
    let viewModel: TabBarVM
    
    init(viewModel: TabBarVM = TabBarVM()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialUI()
        initializeViewControllers()
    }
}

// MARK: - Helper
extension TabBarController {
   
    private func initializeViewControllers() {
        let comicsVC = ComicsVC(viewModel: ComicsVM())
        comicsVC.tabBarItem = UITabBarItem(title: viewModel.comicsTabItemVM.title,
                                           image: viewModel.comicsTabItemVM.image,
                                           selectedImage: viewModel.comicsTabItemVM.selectedImage)
        let charactersVC = CharactersVC()
        charactersVC.tabBarItem = UITabBarItem(title: viewModel.charactersTabItemVM.title,
                                               image: viewModel.charactersTabItemVM.image,
                                               selectedImage: viewModel.charactersTabItemVM.selectedImage)
        let eventsVC = EventsVC()
        eventsVC.tabBarItem = UITabBarItem(title: viewModel.eventsTabItemVM.title,
                                           image: viewModel.eventsTabItemVM.image,
                                           selectedImage: viewModel.eventsTabItemVM.selectedImage)
        self.viewControllers = [comicsVC, charactersVC, eventsVC]
    }
    
    private func setupInitialUI() {
        self.tabBar.tintColor = AppColors.red
        
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
    }
}
