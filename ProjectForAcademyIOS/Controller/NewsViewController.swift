//
//  NewsViewController.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 07.04.2022.
//

import UIKit

class NewsViewController: UIViewController {
    
    

    //MARK: Create item on the NewsViewController
    
    var modelRespons = ModelRespons()
    
    let idNewsTableViewCell = "idNewsCell"
    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Лента"
        
        setConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: idNewsTableViewCell)
        
    }
}

//MARK: - Extension 

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelRespons.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idNewsTableViewCell, for: indexPath) as! NewsTableViewCell
        
        let newNews = modelRespons.news[indexPath.row]
        
        cell.titleNewsLabel.text = newNews.titleNewsLabel
        cell.noteNewsText.text = newNews.noteNewsText
        cell.dataCreateNewsLabel.text = newNews.dataCreateNewsLabel
        cell.imageNewsIcon.image = newNews.imageNewsIcon
        cell.imageNews.image = newNews.imageNews
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 440
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newNews = modelRespons.news[indexPath.row]

        let recordingNewsVC = RecordingNewsViewController()
        recordingNewsVC.news = newNews
        self.navigationController?.pushViewController(recordingNewsVC, animated: true)
    }
    
}

extension NewsViewController {
    
    func setConstraints(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
    }
    
}
    
    

