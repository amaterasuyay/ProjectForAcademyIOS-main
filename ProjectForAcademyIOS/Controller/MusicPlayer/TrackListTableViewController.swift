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
                    self.setupViewModel(nameSong: $0.title ?? "", nameAvtor: $0.subtitle?.rawValue ?? "", imageSong: $0.images?.background ?? "", playTrack: $0.hub?.actions?.last?.uri ?? "")
                })
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupViewModel(nameSong: String, nameAvtor: String, imageSong: String,
                                playTrack: String) -> CellViewModelSong? {
        let url = URL(string: imageSong)
        guard let doneUrl = url else { return nil }
        
        let urlPlayTrack = URL(string: playTrack)
        guard let doneUrlPlayTrack = urlPlayTrack else { return nil }
        
        let cellviewModelSong = CellViewModelSong(nameSong: nameSong, nameAvtor: nameAvtor, imageSong: doneUrl, playTrack: doneUrlPlayTrack)
        return cellviewModelSong
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Музыка"
        view.backgroundColor = .systemGray4
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchTopStories()
        
        tableView.register(TrackListTableViewCell.self, forCellReuseIdentifier: idTrackList)
        navigationItem.hidesBackButton = true
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
        
        let song = viewModels
        let currentTrack = indexPath.row
        let playerVC = MusicPlayerViewController()
        playerVC.modelSong = song
        playerVC.currentTrack = currentTrack
        navigationController?.pushViewController(playerVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
    
    
    
}
