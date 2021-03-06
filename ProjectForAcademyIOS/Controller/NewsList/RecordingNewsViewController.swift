//
//  RecordingNewsViewController.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 11.04.2022.
//

import UIKit

final class RecordingNewsViewController: UIViewController{
    
    //MARK: Create item on the RecordingNewsViewController
    
    private let imageNews: UIImageView = {
        let image = UIImageView(image: UIImage(named: "testImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let titleNewsLabel: UILabel = {
        let label = UILabel()
        label.text = "11"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let noteNewslabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "11"
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 14)
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        return text
    }()
    
    private let dataCreateNewsLabel: UILabel = {
        let label = UILabel()
        label.text = "11"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: viewDidLoad
    
    var news: CellViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Запись"
        setupView()
        setConstraints()
        guard let news = news else { return }
        
        configure(with: news)
        
    }
}

//MARK: extension
extension RecordingNewsViewController {
    
    private func configure(with viewModel: CellViewModel) {
        titleNewsLabel.text = viewModel.titleNews
        noteNewslabel.text = viewModel.discription
        dataCreateNewsLabel.text = viewModel.dataContent
        
        if let data = viewModel.imageData {
            imageNews.image = UIImage(data: data)
        } else if let url = viewModel.imageNews {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    return
                }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.imageNews.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
    private func setupView() {
        view.addSubview(imageNews)
        view.addSubview(titleNewsLabel)
        view.addSubview(noteNewslabel)
        view.addSubview(dataCreateNewsLabel)
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            titleNewsLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            titleNewsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            titleNewsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            titleNewsLabel.heightAnchor.constraint(equalToConstant: 20),
            titleNewsLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            dataCreateNewsLabel.topAnchor.constraint(equalTo: titleNewsLabel.bottomAnchor, constant: -3),
            dataCreateNewsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            dataCreateNewsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            dataCreateNewsLabel.heightAnchor.constraint(equalToConstant: 20),
            dataCreateNewsLabel.widthAnchor.constraint(equalToConstant: 60)
            
        ])
        
        NSLayoutConstraint.activate([
            noteNewslabel.topAnchor.constraint(equalTo: dataCreateNewsLabel.bottomAnchor, constant: 10),
            noteNewslabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            noteNewslabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            imageNews.topAnchor.constraint(equalTo: noteNewslabel.bottomAnchor, constant: 10),
            imageNews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageNews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageNews.heightAnchor.constraint(equalToConstant: 230),
            imageNews.widthAnchor.constraint(equalToConstant: 250)
        ])
        
    }
    
}
