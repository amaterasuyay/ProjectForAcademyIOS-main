//
//  RegistrationViewController.swift
//  ProjectForAcademyIOS
//
//  Created by Nikita on 14.04.2022.
//

import UIKit

final class RegistrationViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private let contentView: UIView = {
       let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
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
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    private let repeatPasswordError: UILabel = {
        let label = UILabel()
        label.text = "Повторить пароль"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    private let loginError: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
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
        textFieldPassword.delegate = self
        textFieldLogin.delegate = self
        textFieldRepeatPassword.delegate = self
        registerForKeyboard()
    }
    
    private func invalidPassword(value: String) -> String? {
        if value.count < 6 {
            return "В пароле должно быть 6 или более цифр"
        }
        if constainsDigit(value: value) {
            return "Пароль должен содержать не менее 1 цифры"
        }
        if constainsUpperCase(value: value) {
            return "Пароль должен содержать не менее 1 буквы"
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
        let regularExpression = "[A-Z0-9a-z._%+-]{3,16}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if value.count < 3 || value.count > 16 {
            return "Длина не может быть меньше 3 или больше 16"
        } else if !predicate.evaluate(with: value) {
            return "Недопустимый символ"
        }
        return nil
    }
    
    private func constainsDigit(value: String) -> Bool {
        let regularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    
    private func constainsUpperCase(value: String) -> Bool {
        let regularExpression = ".*[a-zA-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    
    private func checkForValid() {
        if passwordError.text == "Готово" && textFieldPassword.text == textFieldRepeatPassword.text && loginError.text == "Готово" {
            buttonRegistration.isEnabled = true
        } else {
            buttonRegistration.isEnabled = false
        }
    }
    
    private func registerForKeyboard() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        self.contentView.addGestureRecognizer(tapGestureRecognizer)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 26 , right: 0.0)
        
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

extension String {

   var containsValidCharacter: Bool {
   guard self != "" else { return true }
   let hexSet = CharacterSet(charactersIn: "qwertyuiopasdfghjklzxcvbnm1234567890QWERTYUIOPASDFGHJKLZXCVBNM")
   let newSet = CharacterSet(charactersIn: self)
   return hexSet.isSuperset(of: newSet)

 }
}

extension RegistrationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return string.containsValidCharacter
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(textFieldLogin)
        contentView.addSubview(textFieldPassword)
        contentView.addSubview(textFieldRepeatPassword)
        contentView.addSubview(buttonRegistration)
        contentView.addSubview(buttonBackAuthorization)
        contentView.addSubview(passwordError)
        contentView.addSubview(repeatPasswordError)
        contentView.addSubview(loginError)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textFieldLogin.widthAnchor.constraint(equalToConstant: 300),
            textFieldLogin.heightAnchor.constraint(equalToConstant: 30),
            textFieldLogin.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -190),
            textFieldLogin.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
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
            passwordError.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
        ])
        
        NSLayoutConstraint.activate([
            repeatPasswordError.topAnchor.constraint(equalTo: textFieldRepeatPassword.bottomAnchor, constant: 5),
            repeatPasswordError.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            loginError.topAnchor.constraint(equalTo: textFieldLogin.bottomAnchor, constant: 5),
            loginError.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25)
        ])
        
    }
    
}



