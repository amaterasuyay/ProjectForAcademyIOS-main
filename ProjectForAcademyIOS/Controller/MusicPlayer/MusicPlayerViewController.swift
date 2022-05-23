//
//  MusicPlayerViewController.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 16.05.2022.
//
import AVFoundation
import UIKit

class MusicPlayerViewController: UIViewController {
    
    private let musicImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .red
        return image
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapPlayButton), for: .touchUpInside)
        return button
    }()
    
    private let nextTrack: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let previousTrack: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nameTrack: UILabel = {
        let label = UILabel()
        label.text = "Название трека"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameAuthor: UILabel = {
        let label = UILabel()
        label.text = "Имя автора"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .blue
        slider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
//        slider.addTarget(self, action: #selector(sliderVolume), for: .editingChanged)
        return slider
    }()
    
    private let trackLengthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    private let trackPassedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    var modelSong: CellViewModelSong!
    var player = AVPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Music"
        view.backgroundColor = .systemGray4
        setupView()
        setConstraints()
        configure(with: modelSong)
    }
    
    @objc func tapPlayButton() {
        if player.rate == 0 {
            play(url: modelSong.playTrack!)
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            player.pause()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
//    @objc func sliderVolume(_ slider: UISlider){
//        let value = slider.value
//        playerSound.volume = value
//    }
}

//MARK: extension

extension MusicPlayerViewController {
    
    private func play(url:URL) {
        do{
            let playerItem = AVPlayerItem(url: url)
            self.player = AVPlayer(playerItem: playerItem)
            player.play()
        }
        catch let error as Error {
            print(error.localizedDescription)
        } catch {
            print(error)
        }
    }
    
    private func configure(with viewModel: CellViewModelSong) {
        nameAuthor.text = viewModel.nameAvtor
        nameTrack.text = viewModel.nameSong
        
        if let data = viewModel.imageData {
            musicImage.image = UIImage(data: data)
        } else if let url = viewModel.imageSong {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self.musicImage.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
    private func setupView() {
        view.addSubview(musicImage)
//        view.addSubview(slider)
        view.addSubview(playButton)
//        view.addSubview(nextTrack)
//        view.addSubview(previousTrack)
        view.addSubview(nameTrack)
        view.addSubview(nameAuthor)
//        view.addSubview(trackLengthLabel)
//        view.addSubview(trackPassedLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            musicImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            musicImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            musicImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            musicImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500)
        ])
        
//        NSLayoutConstraint.activate([
//            slider.topAnchor.constraint(equalTo: musicImage.bottomAnchor, constant: 50),
//            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//        ])
        
//        NSLayoutConstraint.activate([
//            trackLengthLabel.widthAnchor.constraint(equalToConstant: 45),
//            trackLengthLabel.heightAnchor.constraint(equalToConstant: 24),
//            trackLengthLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            trackLengthLabel.topAnchor.constraint(equalTo: slider.bottomAnchor)
//        ])
//
//        NSLayoutConstraint.activate([
//            trackPassedLabel.widthAnchor.constraint(equalToConstant: 45),
//            trackPassedLabel.heightAnchor.constraint(equalToConstant: 24),
//            trackPassedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            trackPassedLabel.topAnchor.constraint(equalTo: slider.bottomAnchor)
//        ])
        
        NSLayoutConstraint.activate([
            nameTrack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTrack.centerYAnchor.constraint(equalTo: musicImage.bottomAnchor, constant: 70)
        ])
        
        NSLayoutConstraint.activate([
            nameAuthor.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameAuthor.centerYAnchor.constraint(equalTo: nameTrack.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            playButton.heightAnchor.constraint(equalToConstant: 150),
            playButton.widthAnchor.constraint(equalToConstant: 150),
            playButton.topAnchor.constraint(equalTo: nameAuthor.bottomAnchor, constant: 60),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
//        NSLayoutConstraint.activate([
//            nextTrack.heightAnchor.constraint(equalToConstant: 50),
//            nextTrack.widthAnchor.constraint(equalToConstant: 50),
//            nextTrack.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 10),
//            nextTrack.topAnchor.constraint(equalTo: nameAuthor.bottomAnchor, constant: 60)
//        ])
//
//        NSLayoutConstraint.activate([
//            previousTrack.heightAnchor.constraint(equalToConstant: 50),
//            previousTrack.widthAnchor.constraint(equalToConstant: 50),
//            previousTrack.rightAnchor.constraint(equalTo: playButton.leftAnchor, constant: -10),
//            previousTrack.topAnchor.constraint(equalTo: nameAuthor.bottomAnchor, constant: 60)
//        ])
        
    }
}
