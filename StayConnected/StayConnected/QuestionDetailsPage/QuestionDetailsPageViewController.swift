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
    private var dateLabel = UILabel()
    var questionObject = Question(id: -1, user: "", user_id: -1, subject: "", text: "", tag_list: [], created_at: "", updated_at: "", views_count: -1, votes: -1, answers: [], slug: "")
    
    let collectionViewForAnswears: UICollectionView = {
            let collection: UICollectionView
            let collectionLayout = UICollectionViewFlowLayout()
            collectionLayout.scrollDirection = .vertical
            collectionLayout.itemSize = CGSize(width:  UIScreen.main.bounds.width - 30, height: 112)
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
            collectionStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
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
}

extension QuestionDetailsPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        questionObject.answers.count
        2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCell", for: indexPath) as? DetailsCell
//        cell?.questionObject = questionObject
        return cell ?? UICollectionViewCell()
    }
}

#Preview {
    QuestionDetailsPageViewController()
}
