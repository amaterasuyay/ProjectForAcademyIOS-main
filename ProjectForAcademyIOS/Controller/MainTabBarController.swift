//
//  MainTabBarController.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 17.05.2022.
//

import UIKit

final class MainTabBarController: UITabBarController, UIViewControllerTransitioningDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    private func setupTabBar() {
        
        let newsViewController = createNavController(vc: NewsViewController(), itemName: "Новости", itemImage: "book.circle.fill")
        let trackListTableViewController = createNavController(vc: TrackListTableViewController(), itemName: "Музыка", itemImage: "play.fill")
        
        viewControllers = [newsViewController, trackListTableViewController]
    }
    
    private func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 0)
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        navController.modalPresentationStyle = .fullScreen
        
        return navController
    }
}
