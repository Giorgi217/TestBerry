//
//  ProfilePageViewController.swift
//  StayConnected
//
//  Created by Giorgi on 30.11.24.
//

import UIKit

class ProfilePageViewController: UIViewController {
    private var mainLabel = UILabel()
    private var userName = UILabel()
    private var mail = UILabel()
    private var profileImage = UIImageView()
    private var cameraIcone = UIImageView()
    private var stack = UIStackView()
    
    private var scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    private var contetView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mainLabelSetup()
        profileSetup()
        stackSetup()
    }
    
    private func mainLabelSetup() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(contetView)
        contetView.translatesAutoresizingMaskIntoConstraints = false
        
        contetView.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.font = UIFont(name: "AnekDevanagari-Medium_SemiBold", size: 20)
        mainLabel.text = "Profile"
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contetView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contetView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contetView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contetView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contetView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contetView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1.05),
            
            mainLabel.topAnchor.constraint(equalTo: contetView.topAnchor, constant: 0),
            mainLabel.leadingAnchor.constraint(equalTo: contetView.leadingAnchor, constant: 16)
        ])
    }
    
    private func profileSetup() {
        contetView.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        contetView.addSubview(userName)
        userName.translatesAutoresizingMaskIntoConstraints = false
        contetView.addSubview(mail)
        mail.translatesAutoresizingMaskIntoConstraints = false
        contetView.addSubview(cameraIcone)
        cameraIcone.translatesAutoresizingMaskIntoConstraints = false
        
        userName.text = "Shawn Howard"
        userName.font = UIFont.systemFont(ofSize: 17)
        mail.text = "shawn_howard@gmail.com"
        mail.font = UIFont.systemFont(ofSize: 15)
        mail.textColor = .gray
        profileImage.image = UIImage(named: "profile")
        cameraIcone.image = UIImage(named: "camera")
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalTo: contetView.heightAnchor, multiplier: 0.2),
            profileImage.widthAnchor.constraint(equalTo: contetView.heightAnchor, multiplier: 0.2),
            profileImage.centerXAnchor.constraint(equalTo: contetView.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 24),
            userName.centerXAnchor.constraint(equalTo: contetView.centerXAnchor),
            userName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 33),
            mail.centerXAnchor.constraint(equalTo: contetView.centerXAnchor),
            mail.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 4),
            cameraIcone.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor, constant: 49),
            cameraIcone.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor)
        ])
    }
    
    private func stackSetup() {
        contetView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        let infoLabel = UILabel()
        stack.addSubview(infoLabel)
        infoLabel.text = "Infromation"
        infoLabel.textColor = .defaultgrey
        infoLabel.font = UIFont.boldSystemFont(ofSize: 15)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let lineOne = createLine(text: "Score",point: "25")
        let lineTwo = createLine(text: "Answered Questions",point: "15")
        
        let lineThree = UIStackView()
        lineThree.translatesAutoresizingMaskIntoConstraints = false
        lineThree.axis = .horizontal
        
        let lefIcone = UIImageView()
        lefIcone.image = UIImage(named: "left")
        lineThree.addArrangedSubview(lefIcone)
        
        let logOutLabel = UILabel()
        logOutLabel.text = "  Log out"
        logOutLabel.textColor = .defaultgrey
        logOutLabel.font = UIFont.systemFont(ofSize: 17)
        lineThree.addArrangedSubview(logOutLabel)
        
        let lineFour = UIStackView()
        stack.addSubview(lineFour)
        lineFour.translatesAutoresizingMaskIntoConstraints = false
        lineFour.axis = .horizontal
        lineFour.addArrangedSubview(lineThree)
        addBottomBorderToStack(stack: lineFour, padding: 25)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: mail.bottomAnchor, constant: 59),
            stack.bottomAnchor.constraint(equalTo: contetView.bottomAnchor, constant: 0),
            stack.leadingAnchor.constraint(equalTo: contetView.leadingAnchor, constant: 18),
            stack.trailingAnchor.constraint(equalTo: contetView.trailingAnchor, constant: -18),
            lineOne.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 29),
            lineTwo.topAnchor.constraint(equalTo: lineOne.bottomAnchor, constant: 29),
            lineFour.topAnchor.constraint(equalTo: lineTwo.bottomAnchor, constant: 29),
            lineFour.widthAnchor.constraint(equalTo: stack.widthAnchor),
        ])
        
        addTapGesture(to: lineOne, action: #selector(stack1Tapped))
        addTapGesture(to: lineTwo, action: #selector(stack2Tapped))
        addTapGesture(to: lineFour, action: #selector(stack3Tapped))
    }
    
    private func createLine(text: String, point: String) -> UIStackView {
        let smallStack = UIStackView()
        stack.addSubview(smallStack)
        smallStack.translatesAutoresizingMaskIntoConstraints = false
        smallStack.axis = .horizontal
        smallStack.distribution = .equalCentering
        
        addBottomBorderToStack(stack: smallStack, padding: 12)
        
        let leadLabel = UILabel()
        smallStack.addArrangedSubview(leadLabel)
        leadLabel.text = text
        leadLabel.textColor = .gray
        leadLabel.font = UIFont.systemFont(ofSize: 17)
        leadLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let pointLabel = UILabel()
        smallStack.addArrangedSubview(pointLabel)
        pointLabel.text = point
        pointLabel.textColor = .gray
        pointLabel.font = UIFont.systemFont(ofSize: 17)
        pointLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            smallStack.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            smallStack.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            smallStack.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        return smallStack
    }
    
    private func addBottomBorderToStack(stack: UIStackView, padding: Int) {
        let bottomBorder = UIView()
        bottomBorder.backgroundColor = .defaultgrey
        stack.addSubview(bottomBorder)
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bottomBorder.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
            bottomBorder.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: CGFloat(padding)),
            bottomBorder.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func addTapGesture(to stack: UIStackView, action: Selector) {
            let tapGesture = UITapGestureRecognizer(target: self, action: action)
            stack.addGestureRecognizer(tapGesture)
        }
    
    @objc private func stack1Tapped() {
            print("Score")
        }
    
    @objc private func stack2Tapped() {
        navigationController?.pushViewController(AnsweredQuestionsViewController(), animated: true)
        }
    
    @objc private func stack3Tapped() {
            print("log out")
        navigationController?.pushViewController(LoginView(), animated: true)
        }
}

#Preview {
    ProfilePageViewController()
}
