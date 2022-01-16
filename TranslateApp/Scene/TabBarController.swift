//
//  TabBarController.swift
//  TranslateApp
//
//  Created by 장기화 on 2022/01/14.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let translateViewController = TranslateViewController()
        translateViewController.tabBarItem = UITabBarItem(title: "번역", image: UIImage(systemName: "mic"), selectedImage: UIImage(systemName: "mic.fill"))
        
        let bookmarkViewController = UINavigationController(rootViewController: BookmarkViewController())
        bookmarkViewController.tabBarItem = UITabBarItem(title: "즐겨찾기", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        tabBar.tintColor = .mainTintColor
        
        viewControllers = [translateViewController, bookmarkViewController]
    }


}

