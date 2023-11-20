//
//  TabController.swift
//  25 - Arcitectural Patterns (Additional Task)
//
//  Created by Ani's Mac on 18.11.23.
//

import UIKit

class TabController: UITabBarController {
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        setupTabUI()
    }
    
    // MARK: - Setup Tab
    private func setupTabs() {
        let todayFacts = createNavigation(with: "Today", image: UIImage(systemName: "newspaper"), viewController: TodayFactViewController())
        let randomFacts = createNavigation(with: "Random", image: UIImage(systemName: "quote.closing"), viewController: RandomFactsViewController())
        self.setViewControllers([todayFacts, randomFacts], animated: true)
    }
    
    private func createNavigation(with title: String, image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        
        navigation.tabBarItem.title = title
        navigation.tabBarItem.image = image
        navigation.viewControllers.first?.navigationItem.title = title + " " + "Useless Facts"
        return navigation
    }
    
    // MARK: - Setup Tab UI
    private func setupTabUI() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .lightGray
    }
}
