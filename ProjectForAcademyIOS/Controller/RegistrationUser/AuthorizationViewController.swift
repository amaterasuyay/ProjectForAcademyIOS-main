//
//  AuthorizationViewController.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 06.04.2022.
//

import UIKit

final class AuthorizationViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    //MARK: Create items ot the AuthorizationViewController
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = true
        return scrollView
    }()
    
    private let contentView: UIView = {
       let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
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
        field.placeholder = "Логин"
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
    
    //MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Авторизация пользователя"
        setupViews()
        setConstraints()
        registerForKeyboard()
    }
    
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
//
    private func registerForKeyboard() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        self.contentView.addGestureRecognizer(tapGestureRecognizer)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        scrollView.isScrollEnabled = true
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        scrollView.isScrollEnabled = false
    }
    
    @objc func backgroundTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc private func tapButtonAuthorization (){
        let login = textFieldLogin.text ?? ""
        let password = textFieldPassword.text ?? ""
        let user = findUser(login: login)
        
        if user == nil{
            alertNotFindUser()
        } else if user?.password == password {
            
            let mainTabBar = MainTabBarController()
            
            let appDelegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)
            
            appDelegate?.window?.rootViewController = mainTabBar
            appDelegate?.window?.makeKeyAndVisible()
            DataBaseUserDefaults.shared.setIsLoggedIn(value: true)
            
        } else {
            alertErrorAuthorization()
        }
    }
    
    @objc private func tabButtonExit(){
        exit(0)
    }
    
    @objc private func tapButtonRegistration() {
        navigationController?.pushViewController(RegistrationViewController(), animated: true)
        self.view.endEditing(true)
    }
    
}

// MARK: extension

extension AuthorizationViewController {
    
    private func setupViews(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(labelTitleEmail)
        contentView.addSubview(textFieldLogin)
        contentView.addSubview(labelTitlePassword)
        contentView.addSubview(textFieldPassword)
        contentView.addSubview(buttonAuthorization)
        contentView.addSubview(buttonExit)
        contentView.addSubview(buttonRegistration)
    }
    
    private func setConstraints(){
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//            scrollView.widthAnchor.constraint(equalToConstant: 400),
//            scrollView.heightAnchor.constraint(equalToConstant: 800)
        ])
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            contentView.heightAnchor.constraint(equalToConstant: 580),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelTitleEmail.widthAnchor.constraint(equalToConstant: 90),
            labelTitleEmail.heightAnchor.constraint(equalToConstant: 30),
            labelTitleEmail.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -140),
            labelTitleEmail.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            textFieldLogin.widthAnchor.constraint(equalToConstant: 300),
            textFieldLogin.heightAnchor.constraint(equalToConstant: 30),
            textFieldLogin.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textFieldLogin.centerYAnchor.constraint(equalTo: labelTitleEmail.centerYAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            labelTitlePassword.widthAnchor.constraint(equalToConstant: 90),
            labelTitlePassword.heightAnchor.constraint(equalToConstant: 30),
            labelTitlePassword.centerYAnchor.constraint(equalTo: textFieldLogin.centerYAnchor, constant: 30),
            labelTitlePassword.centerXAnchor.constraint(equalTo: contentView .centerXAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            textFieldPassword.widthAnchor.constraint(equalToConstant: 300),
            textFieldPassword.heightAnchor.constraint(equalToConstant: 30),
            textFieldPassword.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textFieldPassword.centerYAnchor.constraint(equalTo: labelTitlePassword.centerYAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            buttonAuthorization.widthAnchor.constraint(equalToConstant: 150),
            buttonAuthorization.heightAnchor.constraint(equalToConstant: 35),
            buttonAuthorization.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 25),
//            buttonAuthorization.bottomAnchor.constraint(equalTo: buttonRegistration.topAnchor, constant: -20),
            buttonAuthorization.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            buttonAuthorization.trailingAnchor.constraint(equalTo: buttonExit.leadingAnchor, constant: -50)
        ])
        
        NSLayoutConstraint.activate([
            buttonExit.widthAnchor.constraint(equalToConstant: 150),
            buttonExit.heightAnchor.constraint(equalToConstant: 35),
            buttonExit.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 25),
            buttonExit.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            buttonExit.leadingAnchor.constraint(equalTo: buttonAuthorization.leadingAnchor, constant: 190)
        ])
        
        NSLayoutConstraint.activate([
            buttonRegistration.centerXAnchor.constraint(equalTo: textFieldPassword.centerXAnchor),
            buttonRegistration.topAnchor.constraint(equalTo: buttonExit.bottomAnchor, constant: 10)
        ])
    }
}
