//
//  NavigationViewController.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 12.04.2022.
//

import UIKit

class NavigationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createNavController()

    }
    
    func createNavController() -> UINavigationController {
        let navController = UINavigationController(rootViewController: NewsViewController())
        return navController
    }
    

}
