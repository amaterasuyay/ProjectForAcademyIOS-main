//
//  AlertAuthorization.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 07.04.2022.
//

import UIKit

extension AuthorizationViewController {
    
func alertErrorAuthorization(){
    let alert = UIAlertController(title: "Ошибка", message: "Пароль или Email введены не верно!", preferredStyle: .alert)
    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(ok)
    present(alert, animated: true, completion: nil)
    }
}
