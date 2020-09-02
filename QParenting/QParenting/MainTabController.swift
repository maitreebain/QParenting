//
//  MainTabController.swift
//  QParenting
//
//  Created by Maitree Bain on 9/2/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    
    public lazy var resourcesViewController: ResourcesViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "ResourcesViewController") as? ResourcesViewController else {
            return ResourcesViewController()
        }
        vc.tabBarItem = UITabBarItem(title: "Resources", image: UIImage(systemName: "circle"), tag: 0)
        vc.navigationItem.backBarButtonItem?.tintColor = .label
        return vc
    }()
    
    public lazy var forumViewController: ForumViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(identifier: "ResourcesViewController") as? ForumViewController else {
            return ForumViewController()
        }
        vc.tabBarItem = UITabBarItem(title: "Forums", image: UIImage(systemName: "square"), tag: 1)
        vc.navigationItem.backBarButtonItem?.tintColor = .label
        return vc
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [UINavigationController(rootViewController: resourcesViewController), UINavigationController(rootViewController: forumViewController)]
    }
    

}
