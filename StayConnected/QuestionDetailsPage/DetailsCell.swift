//
//  DetailsCell.swift
//  StayConnected
//
//  Created by Giorgi on 04.12.24.
//
import UIKit

final class DetailsCell: UICollectionViewCell {
    var answearObject = Answer(id: -1, text: "lorem lorem loremlorem lorem loremlorem lorem loremlorem lorem loremlorem lorem loremlorem lorem loremlorem lorem loremlorem lorem lorem ", user: "unknown", created_at: "2024 17 12", is_accepted: false)
    var nameLable = UILabel()
    var dateLabel = UILabel()
    var textLabel = UILabel()
    let profileImage = UIImageView()
    var isAccepted = false
//    var btn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeGesture.direction = .left
        addGestureRecognizer(swipeGesture)
    }
    
    @objc func handleSwipe() {
        let acceptContainer = UIView()
        contentView.addSubview(acceptContainer)
        acceptContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let acceptLabel = UILabel()
        acceptLabel.textColor = .white
        acceptContainer.addSubview(acceptLabel)
        acceptLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        if isAccepted {
            acceptLabel.text = "Reject"
            acceptContainer.backgroundColor = .red
            isAccepted = false
        } else {
            acceptLabel.text = "Accept"
            acceptContainer.backgroundColor = .buttonmaincolor
            isAccepted = true
        }
        
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalToConstant: 34),
            profileImage.heightAnchor.constraint(equalToConstant: 34),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -40),
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLable.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 5),
            nameLable.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 0),
            dateLabel.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 3),
            dateLabel.leadingAnchor.constraint(equalTo: nameLable.leadingAnchor),
            textLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 7),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80),
            
            acceptContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            acceptContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            acceptContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            acceptContainer.leadingAnchor.constraint(equalTo: textLabel.trailingAnchor, constant: 0),
            
            acceptLabel.centerXAnchor.constraint(equalTo: acceptContainer.centerXAnchor),
            acceptLabel.centerYAnchor.constraint(equalTo: acceptContainer.centerYAnchor),
        ])
        
        print("HA HA HA HA HA")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(profileImage)
        
        profileImage.image = UIImage(named: "profile")
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFit
        profileImage.layer.cornerRadius = 17
        
        
        nameLable.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLable)
        
        nameLable.textColor = .black
        nameLable.font = .systemFont(ofSize: 15, weight: .bold)
        nameLable.textAlignment = .left
        nameLable.text = answearObject.user
        
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
        dateLabel.textColor = .black
        dateLabel.font = .systemFont(ofSize: 11)
        dateLabel.textAlignment = .left
        dateLabel.text = answearObject.created_at
        
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textLabel)
        
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(btn)
        
        textLabel.textColor = .gray
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.textAlignment = .left
        textLabel.text = answearObject.text
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        
//        btn.setTitle("button", for: .normal)
//        btn.backgroundColor = .blue
        
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalToConstant: 34),
            profileImage.heightAnchor.constraint(equalToConstant: 34),
            profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLable.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 5),
            nameLable.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 0),
            dateLabel.topAnchor.constraint(equalTo: nameLable.bottomAnchor, constant: 3),
            dateLabel.leadingAnchor.constraint(equalTo: nameLable.leadingAnchor),
            textLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 7),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
//            btn.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 70),
//            btn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            btn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
        ])
        
//        btn.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        
    }
    
}



#Preview {
    DetailsCell()
}


