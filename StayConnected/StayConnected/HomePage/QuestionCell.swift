//
//  QuestionCell.swift
//  StayConnected
//
//  Created by Giorgi on 01.12.24.
//

import UIKit

final class QuestionCell: UICollectionViewCell {
    var onTap: (() -> Void)?
    let subject = UILabel()
    let question = UILabel()
    let tags = UILabel()
    var genreLable = UILabel()
    private var stack = UIStackView()
    private var labelStack = UIStackView()
    private var acceptedImg = UIImageView()
    var tagsArr = [Tag]()
    
    private var tagsCollection: UICollectionView = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        setUpGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        contentView.backgroundColor = .white
        stackSetup()
        labelStackSetup()
        setUpReplayLable()
        tagSetup()
    }
    
    private func stackSetup() {
        contentView.layer.cornerRadius = 10
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.distribution = .equalSpacing
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    private func labelStackSetup() {
        stack.addArrangedSubview(labelStack)
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        labelStack.axis = .vertical
        
        labelStack.addArrangedSubview(subject)
        labelStack.addArrangedSubview(question)
        labelStack.addArrangedSubview(tags)
        subject.translatesAutoresizingMaskIntoConstraints = false
        question.translatesAutoresizingMaskIntoConstraints = false
        tags.translatesAutoresizingMaskIntoConstraints = false
        
        subject.text = "Swift Operators"
        subject.font = UIFont.systemFont(ofSize: 13)
        subject.textColor = .gray
        question.text = "How to implement the code"
        question.font = UIFont.systemFont(ofSize: 15)
        question.textColor = .black
        
        acceptedImg.image = UIImage.yes
        stack.addArrangedSubview(acceptedImg)
        acceptedImg.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpReplayLable() {
        contentView.addSubview(genreLable)
        genreLable.text = "replies: 5"
        genreLable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            genreLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            genreLable.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
        ])
        
        genreLable.font = UIFont(name: "Mulish-Regular", size: 11)
        genreLable.textColor = .gray
        genreLable.textAlignment = .center
    }
    
    private func tagSetup() {
        labelStack.addArrangedSubview(tagsCollection)
        tagsCollection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tagsCollection.trailingAnchor.constraint(equalTo: labelStack.trailingAnchor, constant: 0),
            tagsCollection.topAnchor.constraint(equalTo: question.bottomAnchor, constant: 2),
            tagsCollection.heightAnchor.constraint(equalToConstant: 30),
            tagsCollection.widthAnchor.constraint(equalToConstant: 230)
        ])
        
        tagsCollection.register(TagCell.self, forCellWithReuseIdentifier: "TagCell")
        tagsCollection.dataSource = self
    }
}

extension QuestionCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            tagsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard indexPath.row < tagsArr.count else {
                fatalError("Index out of range: indexPath.row = \(indexPath.row), tagsArr.count = \(tagsArr.count)")
            }
        
            let curTag = tagsArr[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as? TagCell

            cell?.genreLable.text = curTag.name

            
        cell?.genreLable.text = curTag.name
            
            return cell ?? UICollectionViewCell()
    }
    
    private func setUpGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        contentView.addGestureRecognizer(tapGesture)
        contentView.isUserInteractionEnabled = true
    }

    @objc private func cellTapped() {
        print("Cell clicked")
        onTap?()
    }
}

#Preview {
    QuestionCell()
}
