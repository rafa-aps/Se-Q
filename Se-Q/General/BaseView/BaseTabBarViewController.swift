//
//  BaseTabBarViewController.swift
//  Se-Q
//
//  Created by rahman fad on 06/05/20.
//  Copyright © 2020 rahman fad. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        let home = homeViewController()
        let feed = feedViewController()
        let cart = cartViewController()
        let profile = profileViewController()
        
        let viewController: [UIViewController] = [home, feed, cart, profile]
        setViewControllers(viewController, animated: true)
        tabBar.tintColor = UIColor(red: 167/255.0, green: 190/255.0, blue: 246/255.0, alpha: 1.0)
        
        let homeImage = UIImage(named: "home")
        home.tabBarItem = UITabBarItem(title: "Home", image: homeImage, tag: 1)
        let feedImage = UIImage(named: "feed")
        feed.tabBarItem = UITabBarItem(title: "Feed", image: feedImage, tag: 2)
        let cartImage = UIImage(named: "cart")
        cart.tabBarItem = UITabBarItem(title: "Cart", image: cartImage, tag: 3)
        let profileImage = UIImage(named: "profile")
        profile.tabBarItem = UITabBarItem(title: "Profile", image: profileImage, tag: 4)
    }
    
    private func homeViewController() -> UIViewController {
        return HomeBuilder.viewController()
    }
    
    private func feedViewController() -> UIViewController {
        return FeedViewController()
    }
    
    private func cartViewController() -> UIViewController {
        return CartViewController()
    }
    
    private func profileViewController() -> UIViewController {
        return ProfileBuilder.viewController(isUsingBackButton: false)
    }
}
