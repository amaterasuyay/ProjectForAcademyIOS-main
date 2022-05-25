//
//  TrackListTableViewCell.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 17.05.2022.
//

import UIKit

final class TrackListTableViewCell: UITableViewCell {
    
    private let imageTrack: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .systemGray4
        return image
    }()
    
    private let nameTrack: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name track"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let nameAvtor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name Avtor"
        label.font = UIFont.boldSystemFont(ofSize: 14)
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

extension TrackListTableViewCell {
    
    func configure(with viewModel: CellViewModelSong) {
        nameAvtor.text = viewModel.nameAvtor
        nameTrack.text = viewModel.nameSong
        
        if let data = viewModel.imageData {
            imageTrack.image = UIImage(data: data)
        } else if let url = viewModel.imageSong {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self.imageTrack.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
    private func setupView() {
        self.addSubview(imageTrack)
        self.addSubview(nameAvtor)
        self.addSubview(nameTrack)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            imageTrack.widthAnchor.constraint(equalToConstant: 50),
            imageTrack.heightAnchor.constraint(equalToConstant: 50),
            imageTrack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            imageTrack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            nameTrack.leadingAnchor.constraint(equalTo: imageTrack.trailingAnchor, constant: 5),
            nameTrack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameTrack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            nameAvtor.leadingAnchor.constraint(equalTo: imageTrack.trailingAnchor, constant: 5),
            nameAvtor.topAnchor.constraint(equalTo: nameTrack.bottomAnchor, constant: 10),
            nameAvtor.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
}
