//
//  AuthorizationViewController.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 06.04.2022.
//

import UIKit

class AuthorizationViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    //MARK: Create items ot the AuthorizationViewController
    
    private let buttonRegistration: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегестрироваться", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.blue, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(tapButtonRegistration), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let buttonAuthorization: UIButton = {
        let button = UIButton()
        button.setTitle("Авторизация", for: .normal)  // Изменение название
        button.setTitleColor(.black, for: .normal)   // Изменение цвета названия
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14) //Изменение шрифта
        button.layer.cornerRadius = 12  // закругляем кнопку
        button.layer.borderWidth = 2    // размер границ
        button.layer.borderColor = UIColor.blue.cgColor  // Цвет границ
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(tapButtonAuthorization), for: .touchUpInside) // Нажатие на кнопку
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let buttonExit: UIButton = {
        let button = UIButton()
        button.setTitle("Выход", for: .normal)       // Изменение название
        button.setTitleColor(.black, for: .normal)  // Изменение цвета названия
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)  //Изменение шрифта
        button.layer.cornerRadius = 12    // закругляем кнопку
        button.layer.borderWidth = 2   // размер границ
        button.layer.borderColor = UIColor.blue.cgColor //Цвет грани
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(tabButtonExit), for: .touchUpInside)  // Нажатие на кнопку
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let textFieldLogin: UITextField = {
        let field = UITextField()
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.blue.cgColor
        field.font = UIFont.systemFont(ofSize: 14)
        field.placeholder = "Email"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))  // Растояние placeholder
        field.leftViewMode = .always
        field.autocapitalizationType = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let textFieldPassword: UITextField = {
        let field = UITextField()
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.blue.cgColor
        field.font = UIFont.systemFont(ofSize: 14)
        field.placeholder = "Пароль"
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))  // Растояние placeholder
        field.leftViewMode = .always
        field.isSecureTextEntry = true     // Маска на пароль
        field.autocapitalizationType = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    private let labelTitleEmail: UILabel = {
        let label = UILabel()
        label.text = "Логин"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelTitlePassword: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: Метод поиска пользователя в массиве
    
    private func findUser(login: String) -> User? {
        let dataBase = DataBaseUserDefaults.shared.users
        for user in dataBase {
            if user.login == login {
                return user
            }
        }
        return nil
    }
    
    
    //MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Авторизация пользователя"
        setupViews()
        setConstraints()
        
    }
    
    //MARK: Выполнение действий селектора
    
    @objc func tapButtonAuthorization (){
        let login = textFieldLogin.text ?? ""
        let password = textFieldPassword.text ?? ""
        let user = findUser(login: login)
        
        if user == nil{
            alertNotFindUser()
        } else if user?.password == password {
            
            let newsViewController = UINavigationController(rootViewController: NewsViewController())
            newsViewController.transitioningDelegate = self
            newsViewController.modalPresentationStyle = .custom
            self.present(newsViewController, animated: true, completion: nil)
            
        } else {
            alertErrorAuthorization()
        }
    }
    
    @objc func tabButtonExit(){
        exit(0)
    }
    
    @objc func tapButtonRegistration() {
        let registrationViewController = UINavigationController(rootViewController: RegistrationViewController())
        registrationViewController.transitioningDelegate = self
        registrationViewController.modalPresentationStyle = .custom
        self.present(registrationViewController, animated: true, completion: nil)
    }
    
}

// MARK: extension

extension AuthorizationViewController {
    
    func setupViews(){
        view.addSubview(buttonRegistration)
        view.addSubview(buttonAuthorization)
        view.addSubview(buttonExit)
        view.addSubview(textFieldLogin)
        view.addSubview(textFieldPassword)
        view.addSubview(labelTitleEmail)
        view.addSubview(labelTitlePassword)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            buttonAuthorization.widthAnchor.constraint(equalToConstant: 150),
            buttonAuthorization.heightAnchor.constraint(equalToConstant: 50),
            buttonAuthorization.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 20),
            buttonAuthorization.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonAuthorization.trailingAnchor.constraint(equalTo: buttonAuthorization.leadingAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            buttonRegistration.widthAnchor.constraint(equalToConstant: 200),
            buttonRegistration.heightAnchor.constraint(equalToConstant: 30),
            buttonRegistration.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonRegistration.centerYAnchor.constraint(equalTo: textFieldPassword.centerYAnchor, constant: 130)
        ])
        
        NSLayoutConstraint.activate([
            buttonExit.widthAnchor.constraint(equalToConstant: 150),
            buttonExit.heightAnchor.constraint(equalToConstant: 50),
            buttonExit.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 20),
            buttonExit.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonExit.leadingAnchor.constraint(equalTo: buttonAuthorization.trailingAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            textFieldLogin.widthAnchor.constraint(equalToConstant: 300),
            textFieldLogin.heightAnchor.constraint(equalToConstant: 30),
            textFieldLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldLogin.centerYAnchor.constraint(equalTo: textFieldPassword.centerYAnchor, constant: -70)
        ])
        
        NSLayoutConstraint.activate([
            textFieldPassword.widthAnchor.constraint(equalToConstant: 300),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 30),
            textFieldPassword.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldPassword.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelTitleEmail.widthAnchor.constraint(equalToConstant: 90),
            labelTitleEmail.heightAnchor.constraint(equalToConstant: 30),
            labelTitleEmail.centerYAnchor.constraint(equalTo: textFieldLogin.centerYAnchor, constant: -30),
            labelTitleEmail.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            labelTitlePassword.widthAnchor.constraint(equalToConstant: 90),
            labelTitlePassword.heightAnchor.constraint(equalToConstant: 30),
            labelTitlePassword.centerYAnchor.constraint(equalTo: textFieldPassword.centerYAnchor, constant: -30),
            labelTitlePassword.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 10)
            
        ])
    }
}
