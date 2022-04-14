//
//  NewsTableViewController.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 07.04.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    
    //MARK: Create item on the NewsTableViewController (cell)
    
        let imageNews: UIImageView = {
           let image = UIImageView(image: UIImage(named: "testImage"))
           image.translatesAutoresizingMaskIntoConstraints = false
            image.contentMode = .scaleAspectFit
        return image
    }()
    
    let imageNewsIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "testImage"))
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
     return image
 }()
    
    let titleNewsLabel: UILabel = {
        let label = UILabel()
        label.text = "11"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .red
        return label
    }()
    
    let noteNewslabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "11"
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 14)
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
                text.backgroundColor = .blue
        return text
    }()
    
    let dataCreateNewsLabel: UILabel = {
        let label = UILabel()
        label.text = "11"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .yellow
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupView()
            setConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
    //MARK: extansion

extension NewsTableViewCell {
        
    func setupView() {
        self.addSubview(imageNewsIcon)
        self.addSubview(imageNews)
        self.addSubview(titleNewsLabel)
        self.addSubview(noteNewslabel)
        self.addSubview(dataCreateNewsLabel)
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            titleNewsLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            titleNewsLabel.leadingAnchor.constraint(equalTo: imageNewsIcon.trailingAnchor),
            titleNewsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            titleNewsLabel.heightAnchor.constraint(equalToConstant: 20),
            titleNewsLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            dataCreateNewsLabel.topAnchor.constraint(equalTo: titleNewsLabel.bottomAnchor, constant: -3),
            dataCreateNewsLabel.leadingAnchor.constraint(equalTo: imageNewsIcon.trailingAnchor, constant: 5),
            dataCreateNewsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            dataCreateNewsLabel.heightAnchor.constraint(equalToConstant: 20),
            dataCreateNewsLabel.widthAnchor.constraint(equalToConstant: 60)
        
        ])
        
        NSLayoutConstraint.activate([
            noteNewslabel.topAnchor.constraint(equalTo: dataCreateNewsLabel.bottomAnchor, constant: 10),
            noteNewslabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            noteNewslabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            noteNewslabel.bottomAnchor.constraint(equalTo: imageNews.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageNews.topAnchor.constraint(equalTo: noteNewslabel.bottomAnchor, constant: 10),
            imageNews.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            imageNews.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            imageNews.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            imageNews.heightAnchor.constraint(equalToConstant: 230),
            imageNews.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            imageNewsIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            imageNewsIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            imageNewsIcon.bottomAnchor.constraint(equalTo: noteNewslabel.topAnchor, constant: -5),
            imageNewsIcon.trailingAnchor.constraint(equalTo: dataCreateNewsLabel.leadingAnchor, constant: -10),
            imageNewsIcon.trailingAnchor.constraint(equalTo: titleNewsLabel.leadingAnchor, constant: -10),
            imageNewsIcon.heightAnchor.constraint(equalToConstant: 50),
            imageNewsIcon.widthAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
}
