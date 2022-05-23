//
//  TrackListTableViewController.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 17.05.2022.
//

import UIKit

class TrackListTableViewController: UITableViewController {
    
    
    private let idTrackList = "idTrackList"
    private var viewModels = [CellViewModelSong]()
    
    private func fetchTopStories() {
        ApiManager.shared.getRequestSong { result in
            switch result {
            case .success(let song):
                self.viewModels = song.compactMap({
                    CellViewModelSong(nameSong: $0.title ?? "No title",
                                      nameAvtor: $0.subtitle?.rawValue ?? "",
                                      imageSong: URL(string: $0.images?.background ?? "no Image")!,
                                      playTrack:URL(string: $0.hub?.actions?.last?.uri ?? "Nope track")!)
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Музыка"
        view.backgroundColor = .systemGray4
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchTopStories()
        
        tableView.register(TrackListTableViewCell.self, forCellReuseIdentifier: idTrackList)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idTrackList, for: indexPath) as? TrackListTableViewCell else {fatalError()}
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let song = viewModels[indexPath.row]
        let playerVC = MusicPlayerViewController()
        playerVC.modelSong = song
        navigationController?.pushViewController(playerVC, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    
    
}
