//
//  NavigationBarController.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 06.04.2022.
//

import UIKit

class NavigationBarController: UINavigationController{

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    // Метод setupTabBar вызывает все наши viewControllers
    
    func setupNavigationBar(){
        
//        let newsViewController = createNavController(vc: NewsViewController(), itemName: "Лента", itemImage: "book.circle")
//        let profileUsersViewController = createNavController(vc: ProfileUsersViewController(), itemName: "Профиль", itemImage: "person.circle")
//
//        viewControllers = [newsViewController, profileUsersViewController]     // Массив viewController
        
    }
    
    func createNavController (vc: UIViewController, itemName: String, itemImage:String) -> UINavigationController{
        
        let item = UINavigationItem(title: itemName, image: UIImage(systemName: itemImage))
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        UITabBar.appearance().backgroundColor = .white
        return navController
    }


}
