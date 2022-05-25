//
//  NewsViewController.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 07.04.2022.
//

import UIKit

final class NewsViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    
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
        title = "Новости"
        
        setConstraints()
        
        fetchTopStories()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: idNewsTableViewCell)
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(tabBackButton))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
    }
    
    @objc private func tabBackButton() {
        
        let navController = UINavigationController()
        let authorizationViewController = AuthorizationViewController()
        
        navController.viewControllers = [authorizationViewController]
        let appDelegate = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)
        
        appDelegate?.window?.rootViewController = navController
        appDelegate?.window?.makeKeyAndVisible()
        
    }
}

//MARK: - Extension 

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func fetchTopStories() {
        ApiManager.shared.getRequestNews { result in
            switch result {
            case .success(let articles):
                self.viewModels = articles.compactMap({
                    self.setupViewModel(titleNews: $0.title , imageNews: $0.image ?? "", discription: $0.content ?? "", dataContent: $0.publishedAt ?? "")
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
   private func setupViewModel(titleNews: String, imageNews: String, discription: String,
                        dataContent: String) -> CellViewModel? {
        let url = URL(string: imageNews)
        guard let doneUrl = url else { return nil }
        let cellviewModel = CellViewModel(imageNews: doneUrl, titleNews: titleNews, discription: discription, dataContent: dataContent)
        return cellviewModel
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
    
    private func setConstraints(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
    }
    
}



