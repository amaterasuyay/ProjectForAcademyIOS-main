//
//  RegistrationViewController.swift
//  ProjectForAcademyIOS
//
//  Created by Nikita on 14.04.2022.
//

import UIKit

final class RegistrationViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    private var textFieldLogin: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите логин"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var textFieldPassword: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите пароль"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var textFieldRepeatPassword: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Повторите пароль"
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blue.cgColor
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var buttonRegistration: UIButton = {
        let button = UIButton()
        button.setTitle("Регестрация", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blue.cgColor
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapButtonRegistration), for: .touchUpInside)
        return button
    }()
    
    private var buttonBackAuthorization: UIButton = {
        let button = UIButton()
        button.setTitle("У меня есть аккаунт", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapButtonBackAuthorization), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Регестрация"
        setupView()
        setConstraints()
        navigationItem.hidesBackButton = true
        
    }
    
    @objc private func tapButtonRegistration() {
        
        let login = textFieldLogin.text ?? ""
        let password = textFieldPassword.text ?? ""
        let repeatPassword = textFieldRepeatPassword.text ?? ""
        
        if login.isEmpty || password.isEmpty || repeatPassword.isEmpty {
            alertEmptyText()
        }
        
        if login.isEmpty == false && password.isEmpty == false && repeatPassword == password {
            DataBaseUserDefaults.shared.saveUser(login: login, password: password)
            alertRegSuccessful()
        } else {
            alertErrorRegestration()
        }
    }
    
    @objc private func tapButtonBackAuthorization() {
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension RegistrationViewController {
    
    private func setupView() {
        view.addSubview(textFieldLogin)
        view.addSubview(textFieldPassword)
        view.addSubview(textFieldRepeatPassword)
        view.addSubview(buttonRegistration)
        view.addSubview(buttonBackAuthorization)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            textFieldLogin.widthAnchor.constraint(equalToConstant: 300),
            textFieldLogin.heightAnchor.constraint(equalToConstant: 30),
            textFieldLogin.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -120),
            textFieldLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textFieldPassword.widthAnchor.constraint(equalToConstant: 300),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 30),
            textFieldPassword.centerXAnchor.constraint(equalTo: textFieldLogin.centerXAnchor),
            textFieldPassword.centerYAnchor.constraint(equalTo: textFieldLogin.centerYAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            textFieldRepeatPassword.widthAnchor.constraint(equalToConstant: 300),
            textFieldRepeatPassword.heightAnchor.constraint(equalToConstant: 30),
            textFieldRepeatPassword.centerXAnchor.constraint(equalTo: textFieldPassword.centerXAnchor),
            textFieldRepeatPassword.centerYAnchor.constraint(equalTo: textFieldPassword.centerYAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            buttonRegistration.widthAnchor.constraint(equalToConstant: 150),
            buttonRegistration.heightAnchor.constraint(equalToConstant: 50),
            buttonRegistration.centerXAnchor.constraint(equalTo: textFieldRepeatPassword.centerXAnchor),
            buttonRegistration.centerYAnchor.constraint(equalTo: textFieldRepeatPassword.centerYAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            buttonBackAuthorization.widthAnchor.constraint(equalToConstant: 200),
            buttonBackAuthorization.heightAnchor.constraint(equalToConstant: 30),
            buttonBackAuthorization.centerXAnchor.constraint(equalTo: buttonRegistration.centerXAnchor),
            buttonBackAuthorization.centerYAnchor.constraint(equalTo: buttonRegistration.centerYAnchor, constant: 60)
        ])
        
    }
    
}


