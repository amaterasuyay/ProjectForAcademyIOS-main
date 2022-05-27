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
        textField.addTarget(self, action: #selector(loginChange), for: .editingChanged)
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
        textField.addTarget(self, action: #selector(passwordChange), for: .editingChanged)
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
        textField.addTarget(self, action: #selector(passwordChange), for: .editingChanged)
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
    
    private let passwordError: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.isHidden = true
        return label
    }()
    
    private let repeatPasswordError: UILabel = {
        let label = UILabel()
        label.text = "Повторить пароль"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.isHidden = true
        return label
    }()
    
    private let loginError: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.isHidden = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Регестрация"
        setupView()
        setConstraints()
        navigationItem.hidesBackButton = true
    }
    
    private func invalidPassword(value: String) -> String? {
        if value.count < 6 {
            return "В пароле должно быть 6 или более цифр"
        }
        return nil
    }
    
    private func invalidRepeatPassword(value: String) -> String? {
        if value != textFieldPassword.text {
            return "Пароль не совпадает"
        }
        return nil
    }
    
    private func invalidLogin(value: String) -> String? {
        if value.count < 3 || value.count > 16 {
            return "Длина не может быть меньше 3 или больше 16"
        }
        return nil
    }
    
    private func checkForValid() {
        if passwordError.text == "Готово" && textFieldPassword.text == textFieldRepeatPassword.text && loginError.text == "Готово" {
            buttonRegistration.isEnabled = true
        } else {
            buttonRegistration.isEnabled = false
        }
    }
    
    @objc private func loginChange() {
        if let login = textFieldLogin.text {
            if let errorMessage = invalidLogin(value: login) {
                loginError.text = errorMessage
                loginError.textColor = .red
                loginError.isHidden = false
            } else {
                loginError.text = "Готово"
                loginError.textColor = .green
            }
        }
        checkForValid()
    }
    
    @objc private func passwordChange() {
        let password = textFieldPassword.text
        let repeatPassword = textFieldRepeatPassword.text
        if let errorMesagePassword = invalidPassword(value: password ?? "") {
            passwordError.text = errorMesagePassword
            passwordError.textColor = .red
            passwordError.isHidden = false
        } else {
            passwordError.text = "Готово"
            passwordError.textColor = .green
        }
        if let errorMesageRepeatPassword = invalidRepeatPassword(value: repeatPassword ?? "") {
            repeatPasswordError.text = errorMesageRepeatPassword
            repeatPasswordError.textColor = .red
            repeatPasswordError.isHidden = false
        } else {
            repeatPasswordError.text = "Готово"
            repeatPasswordError.textColor = .green
        }
        checkForValid()
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
        view.addSubview(passwordError)
        view.addSubview(repeatPasswordError)
        view.addSubview(loginError)
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
            buttonRegistration.centerYAnchor.constraint(equalTo: textFieldRepeatPassword.centerYAnchor, constant: 70)
        ])
        
        NSLayoutConstraint.activate([
            buttonBackAuthorization.widthAnchor.constraint(equalToConstant: 200),
            buttonBackAuthorization.heightAnchor.constraint(equalToConstant: 30),
            buttonBackAuthorization.centerXAnchor.constraint(equalTo: buttonRegistration.centerXAnchor),
            buttonBackAuthorization.centerYAnchor.constraint(equalTo: buttonRegistration.centerYAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            passwordError.topAnchor.constraint(equalTo: textFieldPassword.bottomAnchor, constant: 5),
            passwordError.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55),
        ])
        
        NSLayoutConstraint.activate([
            repeatPasswordError.topAnchor.constraint(equalTo: textFieldRepeatPassword.bottomAnchor, constant: 5),
            repeatPasswordError.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55)
        ])
        
        NSLayoutConstraint.activate([
            loginError.topAnchor.constraint(equalTo: textFieldLogin.bottomAnchor, constant: 5),
            loginError.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 55)
        ])
        
    }
    
}


