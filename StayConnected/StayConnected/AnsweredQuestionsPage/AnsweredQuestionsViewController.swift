//
//  AnsweredQuestionsViewController.swift
//  StayConnected
//
//  Created by Giorgi on 02.12.24.
//

import UIKit

class AnsweredQuestionsViewController: UIViewController {
    private var mainLabelStack = UIStackView()
    private var mainLabel = UILabel()
    private var questionArrHolder = [Question]()
    private var questionArr = [Question]()
    private let viewModel = HomePageViewModel()
    private var tagsArr = ["Ios", "Frontend", "swiftUi","Ios", "Frontend", "swiftUi","Ios", "Frontend", "swiftUi"]
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    var collectionViewForTags: UICollectionView = {
        let collection: UICollectionView
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.minimumLineSpacing = 8
        collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        return collection
    }()
    
    let collectionViewForQuestions: UICollectionView = {
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
        navigationController?.navigationBar.tintColor = .black
        
        viewModel.getQuestions { questions in
            if let questions = questions {
                print("Fetched Questions: \(questions[0].text)")
                DispatchQueue.main.async { [self] in
                    for quest in questions {
                        if quest.user == "Gregory"{
                            self.questionArrHolder.append(quest)
                            print(quest.text)
                        }
                    }
                    questionArr = questionArrHolder
                    mainLabelSetup()
                    searchSetup()
                    setUpcollectionViewForTags()
                    setUpcollectionViewForQuestions()
                    self.collectionViewForQuestions.reloadData()
                }
            } else {
                print("Failed to fetch questions")
            }
        }
    }
    
    private func mainLabelSetup() {
        view.addSubview(mainLabelStack)
        mainLabelStack.translatesAutoresizingMaskIntoConstraints = false
        mainLabelStack.axis = .horizontal
        mainLabelStack.distribution = .equalCentering
        
        mainLabelStack.addArrangedSubview(mainLabel)
        mainLabel.text = "Answered Questions"
        mainLabel.font = UIFont(name: "AnekDevanagari-Medium_SemiBold", size: 20)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainLabelStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainLabelStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            mainLabelStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            mainLabelStack.heightAnchor.constraint(equalToConstant: 26)
        ])
        
    }
    
    private func searchSetup() {
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: mainLabelStack.bottomAnchor, constant: 23),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    
    private func setUpcollectionViewForTags() {
        view.addSubview(collectionViewForTags)
        
        NSLayoutConstraint.activate([
            collectionViewForTags.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            collectionViewForTags.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionViewForTags.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionViewForTags.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        collectionViewForTags.register(TagCell.self, forCellWithReuseIdentifier: "TagCell")
        collectionViewForTags.dataSource = self
    }
    
    private func setUpcollectionViewForQuestions() {
        let collectionStack = UIStackView()
        view.addSubview(collectionStack)
        collectionStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionStack.topAnchor.constraint(equalTo: collectionViewForTags.bottomAnchor, constant: 34),
            collectionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        collectionStack.backgroundColor = .tabGray
        collectionStack.layer.cornerRadius = 12
        
        collectionStack.addArrangedSubview(collectionViewForQuestions)
        NSLayoutConstraint.activate([
            collectionViewForQuestions.topAnchor.constraint(equalTo: collectionStack.topAnchor, constant: 16)
        ])
        
        collectionViewForQuestions.register(QuestionCell.self, forCellWithReuseIdentifier: "QuestionCell")
        collectionViewForQuestions.dataSource = self
    }
    
    
}

extension AnsweredQuestionsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewForTags {
            tagsArr.count
        } else {
            questionArr.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewForTags {
            let curTag = tagsArr[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as? TagCell
            
            cell?.genreLable.text = curTag
            
            return cell ?? UICollectionViewCell()
        } else {
            let curTag = questionArr[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuestionCell", for: indexPath) as? QuestionCell
            cell?.question.text = curTag.text
            cell?.tagsArr = curTag.tag_list
            cell?.subject.text = curTag.subject
            return cell ?? UICollectionViewCell()
        }
    }
}

#Preview {
    AnsweredQuestionsViewController()
}
