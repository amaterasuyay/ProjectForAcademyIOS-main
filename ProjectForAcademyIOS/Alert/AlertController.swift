//
//  AlertAuthorization.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 07.04.2022.
//

import UIKit

extension AuthorizationViewController {
    
    func alertErrorAuthorization(){
        let alert = UIAlertController(title: "Ошибка", message: "Пароль или логин введены не верно!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func alertNotFindUser() {
        let alert = UIAlertController(title: nil, message: "Пользователь не найден", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension RegistrationViewController {
    func alertErrorRegestration(){
        let alert = UIAlertController(title: nil, message: "Пароль не совпадает", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func alertEmptyText() {
        let alert = UIAlertController(title: nil, message: "Заполните поля ввода", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func alertRegSuccessful() {
        let alert = UIAlertController(title: nil, message: "Регестрация прошла успешна", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { Action in
            let mainTabBar = MainTabBarController()
            
            let appDelegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)
            
            appDelegate?.window?.rootViewController = mainTabBar
            appDelegate?.window?.makeKeyAndVisible()
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

extension MusicPlayerViewController {
    
    func alertErrorTrack() {
        let alert = UIAlertController(title: "Ошибка", message: "Это последний трек, вернитесь в список трек листо, и выберите трек.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}
