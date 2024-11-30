//
//  TabBarController.swift
//  StayConnected
//
//  Created by Giorgi on 29.11.24.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        customizeTabBarAppearance()
    }
    
    private func setupTabBar() {
        
        let HomePageVC = UIViewController()
        HomePageVC.view.backgroundColor = .white
        HomePageVC.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(named: "home"),
            selectedImage: UIImage(named: "homeSelect")
        )
        
        let LeaderBoardPageVC = UIViewController()
        LeaderBoardPageVC.view.backgroundColor = .orange
        LeaderBoardPageVC.tabBarItem = UITabBarItem(
            title: "LiderBoard",
            image: UIImage(named: "award"),
            selectedImage: UIImage(named: "awardSelect")
        )
        
        let ProfilePageVC = ProfilePageViewController()
        ProfilePageVC.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(named: "user"),
            selectedImage: UIImage(named: "userSelect")
        )
        
        self.viewControllers = [HomePageVC, LeaderBoardPageVC, ProfilePageVC]
        if let items = tabBar.items {
            for (index, item) in items.enumerated() {
                if index == 4 {
                    item.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
                } else {
                    item.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
                }
            }
        }
 
        tabBar.tintColor = .buttonmaincolor
        tabBar.unselectedItemTintColor = .circlecolor
    }
    
    private func customizeTabBarAppearance() {
        tabBar.backgroundColor = .tabGray
        
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
 
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = 85
        tabBarFrame.origin.y = view.frame.height - 85
        tabBar.frame = tabBarFrame
    }
}
