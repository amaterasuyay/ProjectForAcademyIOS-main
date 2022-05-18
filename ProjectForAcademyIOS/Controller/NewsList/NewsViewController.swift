//
//  NewsViewController.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 07.04.2022.
//

import UIKit

class NewsViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    
    //MARK: Create item on the NewsViewController
    
    private var viewModels = [CellViewModel]()
    private var news = [Article]()
    private let idNewsTableViewCell = "idNewsCell"
    
    private let tableView: UITableView = {
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
        
        fetchTopStories()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: idNewsTableViewCell)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
}

//MARK: - Extension 

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func fetchTopStories() {
        ApiManager.shared.getRequest { result in
            switch result {
            case .success(let articles):
                self.viewModels = articles.compactMap({
                    CellViewModel(imageNews: URL(string: $0.image ?? "")!,
                                  titleNews: $0.title,
                                  discription: $0.content ?? "No content",
                                  dataContent: $0.publishedAt ?? "No data published")
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idNewsTableViewCell, for: indexPath) as? NewsTableViewCell else {fatalError()}
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let news = viewModels[indexPath.row]

        let recordingNewsVC = RecordingNewsViewController()
        recordingNewsVC.news = news
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



