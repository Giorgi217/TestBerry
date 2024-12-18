//
//  HomePageViewController.swift
//  StayConnected
//
//  Created by Giorgi on 01.12.24.
//

import UIKit

class HomePageViewController: UIViewController, QuestionUpdateDelegate {

    
    private var mainLabelStack = UIStackView()
    private var twoOptionStack = UIStackView()
    let firstLabel = UILabel()
    let secondLabel = UILabel()
    private var mainLabel = UILabel()
    private var addIcone = UIImageView()
    let generalBtn = UIButton()
    let personalBtn = UIButton()
    private var tagsArr = ["IOS", "Frontend", "swiftUi","Ios", "Frontend", "swiftUi","Ios", "Frontend", "swiftUi"]
    private var questionArrHolder = [Question]()
    private var questionArr = [Question]()
    private let viewModel = HomePageViewModel()
    private var myUser = Profile(userName: "", email: "", profilePicture: "", score: 0, createdAt: "")
    
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let profileModel = ProfilePageViewModel()
        profileModel.fetchProfile() { [weak self] profile, error in
            if let error = error {
                print("failed: \(error)")
                return
            }
            self?.myUser.userName = profile?.userName ?? "error"
            self?.myUser.email = profile?.email ?? "error"
            self?.myUser.createdAt = profile?.createdAt ?? "error"
            self?.myUser.score = profile?.score ?? 0
        }
        
        frechDate()
        frechTags()
//        questionArrHolder = [
//            Question(id: 1, user: "adfs", user_id: 1, subject: "ad", text: "where", tag_list: [Tag(id: 1, name: "Ios")], created_at: "", updated_at: "", views_count: 1, votes: 1, answers: [], slug: ""),
//            Question(id: 1, user: "f", user_id: 1, subject: "ad", text: "WHO", tag_list: [Tag(id: 1, name: "Frontend")], created_at: "", updated_at: "", views_count: 1, votes: 1, answers: [], slug: ""),
//            Question(id: 1, user: "adfs", user_id: 1, subject: "ad", text: "where", tag_list: [Tag(id: 1, name: "swiftUi")], created_at: "", updated_at: "", views_count: 1, votes: 1, answers: [], slug: ""),
//        ]
//        questionArr = questionArrHolder
        mainLabelSetup()
        twoOptionSetup()
        searchSetup()
        setUpcollectionViewForTags()
        setUpcollectionViewForQuestions()
        searchBar.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNewQuestion), name: .didAddNewQuestion, object: nil)
    }
    
    private func frechDate() {
        viewModel.getQuestions { questions in
            if let questions = questions {
                print("Fetched Questions: \(questions[0].text)")
                DispatchQueue.main.async { [self] in
                    for quest in questions {
                        self.questionArrHolder.append(quest)
                        print(quest.text)
                    }
                    if questionArrHolder.isEmpty {
                        emptyImageSetup()
                    } else {
                        questionArr = questionArrHolder
                        mainLabelSetup()
                        twoOptionSetup()
                        searchSetup()
                        setUpcollectionViewForTags()
                        setUpcollectionViewForQuestions()
                    }
                    self.collectionViewForQuestions.reloadData()
                }
            } else {
                print("Failed to fetch questions")
            }
        }
    }
    
    private func frechTags() {
        tagsArr = []
        viewModel.getTags { tags in
            if let tags = tags {
                print("getting tags date")
                DispatchQueue.main.async { [self] in
                    for tag in tags {
                        self.tagsArr.append(tag.name)
                        print(tag.name)
                    }
                    print("TAGS___________________")
                    print(tagsArr)
                    collectionViewForTags.reloadData()
                }
            } else {
                print("Failed to fetch questions")
            }
        }
    }
    
    @objc func handleNewQuestion(notification: Notification) {
        guard let userInfo = notification.userInfo,
          let _ = userInfo["subject"] as? String,
          let _ = userInfo["questionText"] as? String,
          let _ = userInfo["tags"] as? [String] else {
            return
        }
        print("New question added!")
    }

    private func emptyImageSetup() {
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        firstLabel.text = "No questions yet"
        firstLabel.textColor = .gray
        secondLabel.text = "Be the first to ask one"
        secondLabel.textAlignment = .center
        firstLabel.textAlignment = .center
        
        let img = UIImageView()
        view.addSubview(img)
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "emptySquad")
        img.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            firstLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstLabel.topAnchor.constraint(equalTo: twoOptionStack.bottomAnchor, constant: 91),
            secondLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 13),
            secondLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            img.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            img.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 19),
            img.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
        ])
        
    }
    
    private func mainLabelSetup() {
        view.addSubview(mainLabelStack)
        mainLabelStack.translatesAutoresizingMaskIntoConstraints = false
        mainLabelStack.axis = .horizontal
        mainLabelStack.distribution = .equalCentering
        
        mainLabelStack.addArrangedSubview(mainLabel)
        mainLabel.text = "Questions"
        mainLabel.font = UIFont(name: "AnekDevanagari-Medium_SemiBold", size: 20)
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
        collectionViewForTags.delegate = self
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
        navigationController?.present(AddQuestion(), animated: true)
    }
    
    @objc private func generalBtnTapped() {
        if questionArrHolder.isEmpty {
            firstLabel.text = "No questions yet"
            secondLabel.text = "Be the first to ask one"
        }
        personalBtn.backgroundColor = .defaultgrey
        generalBtn.backgroundColor = .buttonmaincolor
        questionArr = questionArrHolder
        collectionViewForQuestions.reloadData()
        print("General")
    }
    
    @objc private func personalBtnTapped() {
        if questionArrHolder.isEmpty {
            firstLabel.text = "Got a question in mind?"
            secondLabel.text = "Ask it and wait for like-minded people to answer"
        }
        secondLabel.numberOfLines = 0
        secondLabel.textAlignment = .center
        secondLabel.lineBreakMode = .byWordWrapping
        
        personalBtn.backgroundColor = .buttonmaincolor
        generalBtn.backgroundColor = .defaultgrey
        questionArr = []
        for question in questionArrHolder {
            if question.user == myUser.userName {
                questionArr.append(question)
            }
        }
        collectionViewForQuestions.reloadData()
        print("Personal")
    }
    private var currentSelectedTag: String?
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
            
            cell?.onTap = { [weak self] in
                    guard let self = self else { return }
                    print("Navigating to QuestionDetail screen for cell at \(indexPath.row)")
                    let QuestionVC = QuestionDetailsPageViewController()
                    QuestionVC.questionObject = curTag
                    self.navigationController?.pushViewController(QuestionVC, animated: true)
            }
            
            cell?.question.text = curTag.text
            cell?.tagsArr = curTag.tag_list
            cell?.subject.text = curTag.subject
            return cell ?? UICollectionViewCell()
        }
    }
}

extension HomePageViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            if personalBtn.backgroundColor == .buttonmaincolor {
                questionArr = questionArrHolder.filter { $0.user == myUser.userName }
            } else {
                questionArr = questionArrHolder
            }
        } else {
            questionArr = questionArrHolder.filter { $0.text.lowercased().contains(searchText.lowercased()) }
        }
        collectionViewForQuestions.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        if personalBtn.backgroundColor == .buttonmaincolor {
            questionArr = questionArrHolder.filter { $0.user == myUser.userName }
        } else {
            questionArr = questionArrHolder
        }
        
        collectionViewForQuestions.reloadData()
    }
    
    func didAddNewQuestion() {
        frechDate()
        collectionViewForQuestions.reloadData()
        
    }
    
}




extension HomePageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewForTags {
            let selectedTag = tagsArr[indexPath.row]
            print("You clicked on tag: \(selectedTag)")

            if currentSelectedTag == selectedTag {
                // If the same tag is clicked, clear the filter and reset background
                currentSelectedTag = nil
                questionArr = questionArrHolder
                collectionView.deselectItem(at: indexPath, animated: true)
            } else {
                // If a new tag is clicked, filter by the selected tag
                currentSelectedTag = selectedTag
                questionArr = questionArrHolder.filter { question in
                    question.tag_list.contains { tag in
                        tag.name == selectedTag
                    }
                }
            }

            // Reload the questions collection view
            collectionViewForQuestions.reloadData()

            // Change the background color of the selected cell
            if let cell = collectionView.cellForItem(at: indexPath) as? TagCell {
                cell.contentView.backgroundColor = .systemBlue
                cell.genreLable.textColor = .white
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewForTags {
            // Reset the background color of the deselected cell
            if let cell = collectionView.cellForItem(at: indexPath) as? TagCell {
                cell.contentView.backgroundColor = .clear
                cell.genreLable.textColor = .black
            }
        }
    }
}


protocol QuestionUpdateDelegate: AnyObject {
    func didAddNewQuestion()
}


