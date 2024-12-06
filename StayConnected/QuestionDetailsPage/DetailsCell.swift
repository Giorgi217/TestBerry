//
//  DetailsCell.swift
//  StayConnected
//
//  Created by Giorgi on 04.12.24.
//
import UIKit

final class DetailsCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        let profileImage = UIImageView()
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(profileImage)
        
        profileImage.image = UIImage(named: "profile")
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleAspectFit
        profileImage.layer.cornerRadius = 17
        
        let nameLable = UILabel()
        nameLable.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLable)
        
        nameLable.textColor = .black
        nameLable.font = .systemFont(ofSize: 15, weight: .bold)
        nameLable.textAlignment = .left
        nameLable.text = "someone fdas"
        
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        
        dateLabel.textColor = .black
        dateLabel.font = .systemFont(ofSize: 11)
        dateLabel.textAlignment = .left
        dateLabel.text = "2024 18 03"
        
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textLabel)
        
        textLabel.textColor = .gray
        textLabel.font = .systemFont(ofSize: 15)
        textLabel.textAlignment = .left
        textLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris dfd"
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping
        
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
            
        ])
    }
    
}



#Preview {
    DetailsCell()
}


