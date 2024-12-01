//
//  SignUpView.swift
//  StayConnected
//
//  Created by Giorgi Amiranashvili on 29.11.24.
//

import UIKit

class SignUpView: UIViewController, UITextFieldDelegate {
    var parameters: SignUpModel = SignUpModel(userName: "", email: "", password: "")
    let viewModel = SignUpViewModel()
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textColor = .black
        label.text = "Sign Up"
        return label
    }()
    
    let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Full Name"
        label.textColor = .defaultgrey
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let nameView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(
            string: "Name",
            attributes: [.foregroundColor: UIColor.defaultgrey]
        )
        return textField
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = .defaultgrey
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let emailView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [.foregroundColor: UIColor.defaultgrey]
        )
        return textField
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Password"
        label.textColor = .defaultgrey
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let passwordView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(
            string: "● ● ● ● ● ● ●",
            attributes: [.foregroundColor: UIColor.defaultgrey,
                .font: UIFont.systemFont(ofSize: 12)]
        )
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let passwordImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .lock
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let passwordHideButton: UIButton = {
        let button = UIButton()
        button.setImage(.closedeye, for: .normal)
        return button
    }()
    
    let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Confirm Password"
        label.textColor = .defaultgrey
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let confirmPasswordView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    let confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(
            string: "● ● ● ● ● ● ●",
            attributes: [.foregroundColor: UIColor.defaultgrey,
                .font: UIFont.systemFont(ofSize: 12)]
        )
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let confirmPasswordImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .lock
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let confirmPasswordHideButton: UIButton = {
        let button = UIButton()
        button.setImage(.closedeye, for: .normal)
        return button
    }()
    
    let logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .buttonmaincolor
        button.layer.cornerRadius = 12
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        passwordHideButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        confirmPasswordHideButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        emailTextField.delegate = self
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(signUpLabel)
        view.addSubview(fullNameLabel)
        view.addSubview(nameView)
        nameView.addSubview(nameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailView)
        emailView.addSubview(emailTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordView)
        passwordView.addSubview(passwordTextField)
        passwordView.addSubview(passwordImageView)
        passwordView.addSubview(passwordHideButton)
        view.addSubview(confirmPasswordLabel)
        view.addSubview(confirmPasswordView)
        confirmPasswordView.addSubview(confirmPasswordTextField)
        confirmPasswordView.addSubview(confirmPasswordImageView)
        confirmPasswordView.addSubview(confirmPasswordHideButton)
        view.addSubview(logInButton)
        
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordImageView.translatesAutoresizingMaskIntoConstraints = false
        passwordHideButton.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordView.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordImageView.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordHideButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            signUpLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18),
            signUpLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            signUpLabel.heightAnchor.constraint(equalToConstant: 33),
            signUpLabel.widthAnchor.constraint(equalToConstant: 120),
            
            fullNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            fullNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            fullNameLabel.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 43),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 15),
            
            nameView.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8),
            nameView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            nameView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            nameView.heightAnchor.constraint(equalToConstant: 52),
            
            nameTextField.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 8),
            nameTextField.bottomAnchor.constraint(equalTo: nameView.bottomAnchor, constant: -8),
            nameTextField.leftAnchor.constraint(equalTo: nameView.leftAnchor, constant: 16),
            nameTextField.rightAnchor.constraint(equalTo: nameView.rightAnchor, constant: -16),
            
            emailLabel.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 22),
            emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            emailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            emailLabel.heightAnchor.constraint(equalToConstant: 15),
            
            emailView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
            emailView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            emailView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            emailView.heightAnchor.constraint(equalToConstant: 52),
            
            emailTextField.topAnchor.constraint(equalTo: emailView.topAnchor, constant: 8),
            emailTextField.bottomAnchor.constraint(equalTo: emailView.bottomAnchor, constant: -8),
            emailTextField.leftAnchor.constraint(equalTo: emailView.leftAnchor, constant: 16),
            emailTextField.rightAnchor.constraint(equalTo: emailView.rightAnchor, constant: -16),
            
            passwordLabel.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 25),
            passwordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            passwordLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            passwordLabel.heightAnchor.constraint(equalToConstant: 15),
            
            passwordView.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            passwordView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            passwordView.heightAnchor.constraint(equalToConstant: 52),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 8),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: -8),
            passwordTextField.leftAnchor.constraint(equalTo: passwordView.leftAnchor, constant: 56),
            passwordTextField.rightAnchor.constraint(equalTo: passwordView.rightAnchor, constant: -48),
            
            passwordImageView.leftAnchor.constraint(equalTo: passwordView.leftAnchor, constant: 20.25),
            passwordImageView.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 16.75),
            passwordImageView.heightAnchor.constraint(equalToConstant: 18.5),
            passwordImageView.widthAnchor.constraint(equalToConstant: 15.23),
 
            passwordHideButton.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 18),
            passwordHideButton.rightAnchor.constraint(equalTo: passwordView.rightAnchor, constant: -16),
            passwordHideButton.heightAnchor.constraint(equalToConstant: 16),
            passwordHideButton.widthAnchor.constraint(equalToConstant: 16),
            
            confirmPasswordLabel.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 22),
            confirmPasswordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            confirmPasswordLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            confirmPasswordLabel.heightAnchor.constraint(equalToConstant: 15),
            
            confirmPasswordView.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 8),
            confirmPasswordView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            confirmPasswordView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            confirmPasswordView.heightAnchor.constraint(equalToConstant: 52),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordView.topAnchor, constant: 8),
            confirmPasswordTextField.bottomAnchor.constraint(equalTo: confirmPasswordView.bottomAnchor, constant: -8),
            confirmPasswordTextField.leftAnchor.constraint(equalTo: confirmPasswordView.leftAnchor, constant: 56),
            confirmPasswordTextField.rightAnchor.constraint(equalTo: confirmPasswordView.rightAnchor, constant: -48),

            confirmPasswordImageView.leftAnchor.constraint(equalTo: confirmPasswordView.leftAnchor, constant: 20.25),
            confirmPasswordImageView.topAnchor.constraint(equalTo: confirmPasswordView.topAnchor, constant: 16.75),
            confirmPasswordImageView.heightAnchor.constraint(equalToConstant: 18.5),
            confirmPasswordImageView.widthAnchor.constraint(equalToConstant: 15.23),
            
            confirmPasswordHideButton.topAnchor.constraint(equalTo: confirmPasswordView.topAnchor, constant: 18),
            confirmPasswordHideButton.rightAnchor.constraint(equalTo: confirmPasswordView.rightAnchor, constant: -16),
            confirmPasswordHideButton.heightAnchor.constraint(equalToConstant: 16),
            confirmPasswordHideButton.widthAnchor.constraint(equalToConstant: 16),
            
            logInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            logInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            logInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            logInButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        confirmPasswordTextField.isSecureTextEntry.toggle()
        
        let buttonImage = passwordTextField.isSecureTextEntry ? UIImage(named: "closedeye") : UIImage(named: "openeye")
        passwordHideButton.setImage(buttonImage, for: .normal)
        confirmPasswordHideButton.setImage(buttonImage, for: .normal)
    }
    
    @objc func logInButtonTapped() {
        guard let username = nameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty else {
            showAlert(message: "All fields are required.")
            return
        }
        viewModel.register(username: username, email: email, password: password, confirmPassword: confirmPassword) {[weak self] success, errorMessage in
            DispatchQueue.main.async {
                if success {
                    self?.showAlert(message: "Sign-up successful!")
                } else if let errorMessage = errorMessage {
                    self?.showAlert(message: errorMessage)
                }
            }
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField {
            let lowcasedString = string.lowercased()
            if string != lowcasedString {
                textField.text = (textField.text as NSString?)?.replacingCharacters(in: range, with: lowcasedString)
                return false
            }
        }
        return true
    }
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Sign Up", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}


