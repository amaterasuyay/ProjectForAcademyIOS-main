//
//  RecordingNewsViewController.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 11.04.2022.
//

import UIKit

class RecordingNewsViewController: UIViewController{
    
    //MARK: Create item on the RecordingNewsViewController
    
    let imageNews: UIImageView = {
       let image = UIImageView(image: UIImage(named: "testImage"))
       image.translatesAutoresizingMaskIntoConstraints = false
    return image
}()

let imageNewsIcon: UIImageView = {
    let image = UIImageView(image: UIImage(named: "testImage"))
    image.layer.cornerRadius = 25
    image.clipsToBounds = true
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
    //    label.backgroundColor = .red
    return label
}()

let noteNewsText: UITextView = {
    let text = UITextView(frame: .zero, textContainer: nil)
    text.translatesAutoresizingMaskIntoConstraints = false
    text.text = "11"
    text.textColor = .black
    text.font = UIFont.systemFont(ofSize: 14)
    text.isSelectable = true
    text.isEditable = false
    text.dataDetectorTypes = UIDataDetectorTypes.link
    text.showsVerticalScrollIndicator = false
    text.showsHorizontalScrollIndicator = false
     //  text.backgroundColor = .blue
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
    //    label.backgroundColor = .yellow
    return label
}()

    //MARK: viewDidLoad
    
    var news:ModelNews!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Запись"
        setupView()
        setConstraints()
        
        imageNews.image = news.imageNews
        imageNewsIcon.image = news.imageNewsIcon
        titleNewsLabel.text = news.titleNewsLabel
        noteNewsText.text = news.noteNewsText
        dataCreateNewsLabel.text = news.dataCreateNewsLabel
    }
}

//MARK: extension
extension RecordingNewsViewController {
        
    func setupView() {
        view.addSubview(imageNewsIcon)
        view.addSubview(imageNews)
        view.addSubview(titleNewsLabel)
        view.addSubview(noteNewsText)
        view.addSubview(dataCreateNewsLabel)
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            titleNewsLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            titleNewsLabel.leadingAnchor.constraint(equalTo: imageNewsIcon.trailingAnchor),
            titleNewsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            titleNewsLabel.heightAnchor.constraint(equalToConstant: 20),
            titleNewsLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            dataCreateNewsLabel.topAnchor.constraint(equalTo: titleNewsLabel.bottomAnchor, constant: -3),
            dataCreateNewsLabel.leadingAnchor.constraint(equalTo: imageNewsIcon.trailingAnchor, constant: 5),
            dataCreateNewsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dataCreateNewsLabel.heightAnchor.constraint(equalToConstant: 20),
            dataCreateNewsLabel.widthAnchor.constraint(equalToConstant: 60)
        
        ])
        
        NSLayoutConstraint.activate([
            noteNewsText.topAnchor.constraint(equalTo: dataCreateNewsLabel.bottomAnchor, constant: 10),
            noteNewsText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            noteNewsText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            noteNewsText.heightAnchor.constraint(equalToConstant: 400),
            noteNewsText.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            imageNews.topAnchor.constraint(equalTo: noteNewsText.bottomAnchor, constant: 10),
            imageNews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageNews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageNews.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5),
            imageNews.heightAnchor.constraint(equalToConstant: 230),
            imageNews.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            imageNewsIcon.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            imageNewsIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            imageNewsIcon.bottomAnchor.constraint(equalTo: noteNewsText.topAnchor, constant: -5),
            imageNewsIcon.trailingAnchor.constraint(equalTo: dataCreateNewsLabel.leadingAnchor, constant: -10),
            imageNewsIcon.trailingAnchor.constraint(equalTo: titleNewsLabel.leadingAnchor, constant: -10),
            imageNewsIcon.heightAnchor.constraint(equalToConstant: 50),
            imageNewsIcon.widthAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
}
