//
//  ProfileUsersViewController.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 05.04.2022.
//

import UIKit

class ProfileViewController: UIViewController{
    
    let headerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Профиль"
        
        setupView()
        setConstraints()
    }
    
}

//MARK: Extencion

extension ProfileViewController {
    
    func setupView(){
        view.addSubview(headerView)
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 95),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            headerView.heightAnchor.constraint(equalToConstant: 90),
            headerView.widthAnchor.constraint(equalToConstant: 105)
        ])
        
    }
}
