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
    let arrViewController: [UIViewController]
    
    init(viewModel: TabBarVM,
         viewControllers: [UIViewController]) {
        self.viewModel = viewModel
        self.arrViewController = viewControllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialUI()
        setupViewControllers()
        setupTabBars()
    }
}

// MARK: - Helper
extension TabBarController {
    private func setupInitialUI() {
        self.tabBar.tintColor = AppColors.red
        
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
    }
    
    private func setupViewControllers() {
        setViewControllers(arrViewController, animated: false)
    }
   
    private func setupTabBars() {
        guard let viewControllers = viewControllers,
              viewControllers.count == viewModel.tabBarItemVMs.count else {
            Log.error("Mismatched number of viewControllers: \(String(describing: viewControllers?.count)) and number of tabBar view models: \(viewModel.tabBarItemVMs.count)")
            return
        }
        for index in viewControllers.indices {
            let viewController = viewControllers[index]
            let tabBarVM = viewModel.tabBarItemVMs[index]
            viewController.tabBarItem = UITabBarItem(title: tabBarVM.title,
                                                     image: tabBarVM.image,
                                                     selectedImage: tabBarVM.selectedImage)
        }
    }
}
