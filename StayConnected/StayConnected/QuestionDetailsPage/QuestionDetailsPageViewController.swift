//
//  QuestionDetailsPageViewController.swift
//  StayConnected
//
//  Created by Giorgi on 03.12.24.
//

import UIKit

class QuestionDetailsPageViewController: UIViewController {
    private var subjectLabel = UILabel()
    private var questionLabel = UILabel()
    private var mailLabel = UILabel()
    private var dateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelSetup()
    }
    
    private func labelSetup() {
        view.addSubview(subjectLabel)
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        subjectLabel.text = "Subject Object"
        subjectLabel.textColor = .gray
        subjectLabel.font = UIFont.systemFont(ofSize: 13)
        
        view.addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.text = "VoiceOver is a central part of Apple's accessibility system, to the point not accessible to other accessibility systems in iOS?"
        questionLabel.textColor = .black
        questionLabel.font = UIFont.systemFont(ofSize: 16)
        questionLabel.numberOfLines  = 0
        questionLabel.lineBreakMode = .byWordWrapping
        
        NSLayoutConstraint.activate([
            subjectLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            subjectLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subjectLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            questionLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor, constant: 4),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

#Preview {
    QuestionDetailsPageViewController()
}
