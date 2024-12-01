//
//  HomePageViewController.swift
//  StayConnected
//
//  Created by Giorgi on 01.12.24.
//

import UIKit

class HomePageViewController: UIViewController {
    private var mainLabelStack = UIStackView()
    private var twoOptionStack = UIStackView()
    private var mainLabel = UILabel()
    private var addIcone = UIImageView()
    let generalBtn = UIButton()
    let personalBtn = UIButton()
    private var tagsArr = ["Ios", "Frontend", "swiftUi","Ios", "Frontend", "swiftUi","Ios", "Frontend", "swiftUi"]
    private var questionArr = [QuestionModel(subject: "swift subject", text: "How to do delegates?", tags: ["swift", "Ios"]), QuestionModel(subject: "swift 2 subject", text: "How to do delegates?", tags: ["swift", "Ios"]), QuestionModel(subject: "swift 3 subject", text: "How to do delegates?", tags: ["swift", "Ios"])]
    
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
        mainLabelSetup()
        twoOptionSetup()
        searchSetup()
        setUpcollectionViewForTags()
        setUpcollectionViewForQuestions()
    }
    
    private func mainLabelSetup() {
        view.addSubview(mainLabelStack)
        mainLabelStack.translatesAutoresizingMaskIntoConstraints = false
        mainLabelStack.axis = .horizontal
        mainLabelStack.distribution = .equalCentering
        
        mainLabelStack.addArrangedSubview(mainLabel)
        mainLabel.text = "Questions"
        mainLabel.font = UIFont.boldSystemFont(ofSize: 20)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        mainLabelStack.addArrangedSubview(addIcone)
        addIcone.translatesAutoresizingMaskIntoConstraints = false
        addIcone.image = UIImage(systemName: "plus")
        addIcone.tintColor = .buttonmaincolor
        
        
        
        NSLayoutConstraint.activate([
            mainLabelStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainLabelStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            mainLabelStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            mainLabelStack.heightAnchor.constraint(equalToConstant: 26)
        ])
        
        addTapGesture(to: addIcone, action: #selector(addQuestion))
    }
    
    private func twoOptionSetup() {
        view.addSubview(twoOptionStack)
        twoOptionStack.translatesAutoresizingMaskIntoConstraints = false
        twoOptionStack.axis = .horizontal
        twoOptionStack.distribution = .fillEqually
        twoOptionStack.spacing = 10
        
        twoOptionStack.addArrangedSubview(generalBtn)
        twoOptionStack.addArrangedSubview(personalBtn)
        generalBtn.translatesAutoresizingMaskIntoConstraints = false
        personalBtn.translatesAutoresizingMaskIntoConstraints = false
        
        generalBtn.setTitle("General", for: .normal)
        generalBtn.backgroundColor = .buttonmaincolor
        generalBtn.layer.cornerRadius = 12
        
        personalBtn.setTitle("Personal", for: .normal)
        personalBtn.backgroundColor = .defaultgrey
        personalBtn.layer.cornerRadius = 12
        
        NSLayoutConstraint.activate([
            twoOptionStack.topAnchor.constraint(equalTo: mainLabelStack.bottomAnchor, constant: 20),
            twoOptionStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            twoOptionStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            twoOptionStack.heightAnchor.constraint(equalToConstant: 39),
        ])
        generalBtn.addTarget(self, action: #selector(generalBtnTapped), for: .touchUpInside)
        personalBtn.addTarget(self, action: #selector(personalBtnTapped), for: .touchUpInside)
        
    }
    
    private func searchSetup() {
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: twoOptionStack.bottomAnchor, constant: 19),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    
    private func addTapGesture(to item: UIImageView, action: Selector) {
        item.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        item.addGestureRecognizer(tapGesture)
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
    
    @objc private func addQuestion() {
        print("add")
    }
    
    @objc private func generalBtnTapped() {
        personalBtn.backgroundColor = .defaultgrey
        generalBtn.backgroundColor = .buttonmaincolor
        questionArr = [QuestionModel(subject: "swift subject", text: "How to do delegates?", tags: ["swift", "Ios"]), QuestionModel(subject: "swift 2 subject", text: "How to do delegates?", tags: ["swift", "Ios"]), QuestionModel(subject: "swift 3 subject", text: "How to do delegates?", tags: ["swift", "Ios"]), QuestionModel(subject: "swift subject", text: "How to do delegates?", tags: ["swift", "Ios"]), QuestionModel(subject: "swift 2 subject", text: "How to do delegates?", tags: ["swift", "Ios"]), QuestionModel(subject: "swift 3 subject", text: "How to do delegates?", tags: ["swift", "Ios"]), QuestionModel(subject: "swift subject", text: "How to do delegates?", tags: ["swift", "Ios"]), QuestionModel(subject: "swift 2 subject", text: "How to do delegates?", tags: ["swift", "Ios"]), QuestionModel(subject: "swift 3 subject", text: "How to do delegates?", tags: ["swift", "Ios"])]
        collectionViewForQuestions.reloadData()
        print("General")
    }
    
    @objc private func personalBtnTapped() {
        personalBtn.backgroundColor = .buttonmaincolor
        generalBtn.backgroundColor = .defaultgrey
        questionArr =  [QuestionModel(subject: "swift subject", text: "Scrollable?", tags: ["swift", "Ios", "FrontEnd"]), QuestionModel(subject: "swift 2 subject", text: "How to do delegates?", tags: ["swift", "Ios"])]
        collectionViewForQuestions.reloadData()
        print("Personal")
    }
}


extension HomePageViewController: UICollectionViewDataSource {
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
            cell?.tagsArr = curTag.tags
            cell?.subject.text = curTag.subject
            return cell ?? UICollectionViewCell()
        }
    }
}

#Preview {
    HomePageViewController()
}
