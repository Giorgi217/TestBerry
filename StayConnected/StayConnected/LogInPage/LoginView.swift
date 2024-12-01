//
//  LoginView.swift
//  StayConnected
//
//  Created by Giorgi Amiranashvili on 28.11.24.
//

import UIKit

class LoginView: UIViewController, UITextFieldDelegate {
    
    let viewmodel = LogInViewModel()
    
    let logInLabel: UILabel = {
        let label = UILabel()
        label.text = "Log In"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    let emaiLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = .defaultgrey
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let userNameView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        return view
    }()
    
    let userNameTextField: UITextField = {
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
        label.text = "Password"
        label.textColor = .defaultgrey
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let passwordResetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password?", for: .normal)
        button.titleLabel?.textColor = .black
        button.setTitleColor(.defaultgrey, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return button
    }()
    
    let passwordView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        return view
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(
            string: "● ● ● ● ● ● ● ",
            attributes: [.foregroundColor: UIColor(.circlecolor),
                         .font: UIFont.systemFont(ofSize: 12)]
        )
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let passwordHideButton: UIButton = {
        let button = UIButton()
        button.setImage(.closedeye, for: .normal)
        return button
    }()
    
    let passwordImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .lock
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "New To StayConnected?"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .defaultgrey
        return label
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.defaultgrey, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
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
        logInButton.addTarget(self, action: #selector(logIntapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUptapped), for: .touchUpInside)
        userNameTextField.delegate = self
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(logInLabel)
        view.addSubview(emaiLabel)
        view.addSubview(userNameView)
        userNameView.addSubview(userNameTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordResetButton)
        view.addSubview(passwordView)
        passwordView.addSubview(passwordTextField)
        passwordView.addSubview(passwordHideButton)
        passwordView.addSubview(passwordImageView)
        view.addSubview(signUpLabel)
        view.addSubview(signUpButton)
        view.addSubview(logInButton)
        
        logInLabel.translatesAutoresizingMaskIntoConstraints = false
        emaiLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameView.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordResetButton.translatesAutoresizingMaskIntoConstraints = false
        passwordView.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordHideButton.translatesAutoresizingMaskIntoConstraints = false
        passwordImageView.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logInLabel.heightAnchor.constraint(equalToConstant: 35),
            logInLabel.widthAnchor.constraint(equalToConstant: 111),
            
            emaiLabel.topAnchor.constraint(equalTo: logInLabel.bottomAnchor, constant: 76),
            emaiLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            emaiLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            emaiLabel.heightAnchor.constraint(equalToConstant: 15),
            
            userNameView.topAnchor.constraint(equalTo: emaiLabel.bottomAnchor, constant: 8),
            userNameView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            userNameView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            userNameView.heightAnchor.constraint(equalToConstant: 52),
            
            userNameTextField.topAnchor.constraint(equalTo: userNameView.topAnchor, constant: 8),
            userNameTextField.bottomAnchor.constraint(equalTo: userNameView.bottomAnchor, constant: -8),
            userNameTextField.leftAnchor.constraint(equalTo: userNameView.leftAnchor, constant: 16),
            userNameTextField.rightAnchor.constraint(equalTo: userNameView.rightAnchor, constant: -16),
            
            passwordLabel.topAnchor.constraint(equalTo: userNameView.bottomAnchor, constant: 39),
            passwordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            passwordLabel.widthAnchor.constraint(equalToConstant: 56),
            passwordLabel.heightAnchor.constraint(equalToConstant: 15),
            
            passwordResetButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            passwordResetButton.topAnchor.constraint(equalTo: userNameView.bottomAnchor, constant: 39),
            passwordResetButton.widthAnchor.constraint(equalToConstant: 115),
            passwordResetButton.heightAnchor.constraint(equalToConstant: 15),
            
            passwordView.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 33),
            passwordView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            passwordView.heightAnchor.constraint(equalToConstant: 52),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 8),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: -8),
            passwordTextField.leftAnchor.constraint(equalTo: passwordView.leftAnchor, constant: 56),
            passwordTextField.rightAnchor.constraint(equalTo: passwordView.rightAnchor, constant: -48),
            
            passwordHideButton.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 18),
            passwordHideButton.rightAnchor.constraint(equalTo: passwordView.rightAnchor, constant: -16),
            passwordHideButton.heightAnchor.constraint(equalToConstant: 16),
            passwordHideButton.widthAnchor.constraint(equalToConstant: 16),
            
            passwordImageView.leftAnchor.constraint(equalTo: passwordView.leftAnchor, constant: 20.25),
            passwordImageView.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 16.75),
            passwordImageView.heightAnchor.constraint(equalToConstant: 18.5),
            passwordImageView.widthAnchor.constraint(equalToConstant: 15.23),
            
            signUpLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
            signUpLabel.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 25),
            signUpLabel.heightAnchor.constraint(equalToConstant: 15),
            signUpLabel.widthAnchor.constraint(equalToConstant: 141),
            
            signUpButton.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 25),
            signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -33),
            signUpButton.heightAnchor.constraint(equalToConstant: 15),
            signUpButton.widthAnchor.constraint(equalToConstant: 69),
            
            logInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            logInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            logInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
            logInButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
    
    @objc func togglePasswordVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        let buttonImage = passwordTextField.isSecureTextEntry ? UIImage(named: "closedeye") : UIImage(named: "openeye")
             passwordHideButton.setImage(buttonImage, for: .normal)
    }
    
    @objc func logIntapped() {
        viewmodel.logIn(email: userNameTextField.text!, password: passwordTextField.text!) {[weak self] success, errorMessage in
            DispatchQueue.main.async {
                if success {
                    let addQuestion = AddQuestion()
                    self?.navigationController?.present(addQuestion, animated: true)
                } else {
                    self?.showAlert(message: errorMessage)
                }
                let addQuestion = AddQuestion()
                self?.navigationController?.present(addQuestion, animated: true)
            }
        }
    }
    
    @objc func signUptapped() {
        let signUpView = SignUpView()
        navigationController?.pushViewController(signUpView, animated: true)
    }
    
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == userNameTextField {
            let lowercasedString = string.lowercased()
            if string != lowercasedString {
                textField.text = (textField.text as NSString?)?.replacingCharacters(in: range, with: lowercasedString)
                return false
            }
        }
        return true
    }
  
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Log In", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

