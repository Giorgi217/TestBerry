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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mainLabelSetup()
        profileSetup()
    }
    
    private func mainLabelSetup() {
        view.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.text = "Profile"
        mainLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    private func profileSetup() {
        view.addSubview(profileImage)
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userName)
        userName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mail)
        mail.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cameraIcone)
        cameraIcone.translatesAutoresizingMaskIntoConstraints = false
        
        userName.text = "Shawn Howard"
        userName.font = UIFont.systemFont(ofSize: 17)
        mail.text = "shawn_howard@gmail.com"
        mail.font = UIFont.systemFont(ofSize: 15)
        mail.textColor = .gray
        profileImage.image = UIImage(named: "profile")
        cameraIcone.image = UIImage(named: "camera")
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            profileImage.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 24),
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 33),
            mail.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mail.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 4),
            cameraIcone.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor, constant: 49),
            cameraIcone.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor)
        ])
    }
}

#Preview {
    ProfilePageViewController()
}
