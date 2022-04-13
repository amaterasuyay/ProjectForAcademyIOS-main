//
//  ProfileTableViewCell.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 07.04.2022.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    let avatarImage: UIImageView = {
       let image = UIImageView(image: UIImage(named: "testImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Name"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .green
        setupView()
        setConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

    //MARK: Extension

extension ProfileTableViewCell {
    
    func setupView() {
        self.addSubview(nameLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20)
        ])
        
    }
    
}
