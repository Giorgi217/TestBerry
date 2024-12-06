//
//  QuestionDetailsPageViewController.swift
//  StayConnected
//
//  Created by Giorgi on 03.12.24.
//

import UIKit

class QuestionDetailsPageViewController: UIViewController {
    var viewModel = HomePageViewModel()
    private var subjectLabel = UILabel()
    private var questionLabel = UILabel()
    private var dateLabel = UILabel()
    var questionObject = Question(id: -1, user: "geogre", user_id: -1, subject: "easy easy bro", text: "is it really so easy?", tag_list: [], created_at: "", updated_at: "", views_count: -1, votes: -1, answers: [], slug: "")
    
    let questionView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        return view
    }()
    
    let questionTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .left
        textField.attributedPlaceholder = NSAttributedString(
            string: "Type your reply here",
            attributes: [.foregroundColor: UIColor.defaultgrey]
        )
        
        return textField
    }()
    
    let addQuestionButton: UIButton = {
        let button = UIButton()
        button.setImage(.lightarrow, for: .normal)
        return button
    }()
    
    let collectionViewForAnswears: UICollectionView = {
            let collection: UICollectionView
            let collectionLayout = UICollectionViewFlowLayout()
            collectionLayout.scrollDirection = .vertical
        collectionLayout.itemSize = CGSize(width:  UIScreen.main.bounds.width - 30, height: 150)
            collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 250, height: 250), collectionViewLayout: collectionLayout)
            collection.translatesAutoresizingMaskIntoConstraints = false
            collection.backgroundColor = .clear
            return collection
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        labelSetup()
        setUpcollectionViewForAnswers()
        textFieldSetup()
    }
    
    private func labelSetup() {
        view.addSubview(subjectLabel)
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        subjectLabel.text = questionObject.subject
        subjectLabel.textColor = .gray
        subjectLabel.font = UIFont.systemFont(ofSize: 13)
        
        view.addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.text = questionObject.text
        questionLabel.textColor = .black
        questionLabel.font = UIFont.systemFont(ofSize: 16)
        questionLabel.numberOfLines  = 0
        questionLabel.lineBreakMode = .byWordWrapping
        
        view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = questionObject.user + " asked on " + questionObject.created_at
        dateLabel.textColor = .gray
        dateLabel.font = UIFont.systemFont(ofSize: 13)
        
        NSLayoutConstraint.activate([
            subjectLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            subjectLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subjectLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            questionLabel.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor, constant: 4),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dateLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func setUpcollectionViewForAnswers() {
        let collectionStack = UIStackView()
        view.addSubview(collectionStack)
        collectionStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionStack.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 34),
            collectionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300)
        ])
        collectionStack.backgroundColor = .tabGray
        collectionStack.layer.cornerRadius = 12
        
        collectionStack.addArrangedSubview(collectionViewForAnswears)
        NSLayoutConstraint.activate([
            collectionViewForAnswears.topAnchor.constraint(equalTo: collectionStack.topAnchor, constant: 16)
        ])
//        collectionStack.backgroundColor = .orange
//        collectionViewForAnswears.backgroundColor = .red
        collectionViewForAnswears.register(DetailsCell.self, forCellWithReuseIdentifier: "DetailsCell")
        collectionViewForAnswears.dataSource = self
    }
    
    private func textFieldSetup() {
        view.addSubview(questionView)
        view.addSubview(questionTextField)
        view.addSubview(addQuestionButton)
        questionTextField.translatesAutoresizingMaskIntoConstraints = false
        addQuestionButton.translatesAutoresizingMaskIntoConstraints = false
        questionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionView.topAnchor.constraint(equalTo: collectionViewForAnswears.bottomAnchor, constant: 40),
            questionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            questionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            questionView.heightAnchor.constraint(equalToConstant: 43),
            
            addQuestionButton.topAnchor.constraint(equalTo: questionView.topAnchor, constant: 12),
            addQuestionButton.rightAnchor.constraint(equalTo: questionView.rightAnchor, constant: -12),
            addQuestionButton.heightAnchor.constraint(equalToConstant: 18),
            addQuestionButton.widthAnchor.constraint(equalToConstant: 21),
            
            questionTextField.topAnchor.constraint(equalTo: questionView.topAnchor, constant: 8),
            questionTextField.bottomAnchor.constraint(equalTo: questionView.bottomAnchor, constant: -8),
            questionTextField.leftAnchor.constraint(equalTo: questionView.leftAnchor, constant: 16),
            questionTextField.rightAnchor.constraint(equalTo: addQuestionButton.rightAnchor, constant: -30),
        ])
        
        addQuestionButton.addTarget(self, action: #selector(addQuestionButtonTapped), for: .touchUpInside)
    }
    
    @objc func addQuestionButtonTapped() {
        let answearText = questionTextField.text ?? "idk what to do"
        print(answearText)
        viewModel.addAnswear(text: answearText, questionid: questionObject.id)
        questionTextField.text = ""
    }
}

extension QuestionDetailsPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        questionObject.answers.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCell", for: indexPath) as? DetailsCell
        cell?.answearObject = self.questionObject.answers[indexPath.row]
        
        cell?.nameLable.text = questionObject.answers[indexPath.row].user
        cell?.dateLabel.text = questionObject.answers[indexPath.row].created_at
        cell?.textLabel.text = questionObject.answers[indexPath.row].text
        cell?.isAccepted = questionObject.answers[indexPath.row].is_accepted
        return cell ?? UICollectionViewCell()
    }
}

#Preview {
    QuestionDetailsPageViewController()
}
