//
//  MusicPlayerViewController.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 16.05.2022.
//
import AVFoundation
import UIKit

final class MusicPlayerViewController: UIViewController {
    
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
        button.addTarget(self, action: #selector(tapNextTrack), for: .touchUpInside)
        return button
    }()
    
    private let previousTrack: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapPreviousTrack), for: .touchUpInside)
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
    
    private let volumeLabel: UILabel = {
        let label = UILabel()
        label.text = "Громкость"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sliderLenghtTrack: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .blue
        slider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        slider.addTarget(self, action: #selector(sliderLenghtComposition), for: .valueChanged)
        return slider
    }()
    
    private let sliderVolumeTrack: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .blue
        slider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        slider.addTarget(self, action: #selector(volumeTrack), for: .valueChanged)
        slider.value = 0.5
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
    
    
    var modelSong: [CellViewModelSong] = []
    var currentTrack = 0
    private var status = false
    private var playerItem: AVPlayerItem?
    private var player = AVPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Плеер"
        view.backgroundColor = .systemGray4
        setupView()
        setConstraints()
        configure(with: modelSong[currentTrack])
        setupAudioContent()
    }
    
    private func setupAudioContent() {
        let url = modelSong[currentTrack].playTrack
        if let url = url {
            playerItem = AVPlayerItem(url: url)
            NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidPlayToEndTime), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
            player.replaceCurrentItem(with: playerItem)
            sliderUpdateValue()
        }
    }
    
    private func sliderUpdateValue() {
        let interval = CMTime(value: 1, timescale: 2)
        
        player.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { (progressTime) in
            let currentTime = CMTimeGetSeconds(progressTime)
            let timeSecond = String(format: "%02d", Int(currentTime.truncatingRemainder(dividingBy: 60)))
            let timeMinute = String(format: "%02d", Int(currentTime / 60))
            self.trackPassedLabel.text = "\(timeMinute):\(timeSecond)"
            
            
            let duration = CMTimeGetSeconds((self.player.currentItem?.asset.duration)!)
            let minutesText = Int(duration) / 60 % 60
            let secondsText = Int(duration) % 60
            let strDuration = String(format:"%02d:%02d", minutesText, secondsText)
            self.trackLengthLabel.text = strDuration
            if let duration = self.player.currentItem?.duration {
                let durationSeconds = CMTimeGetSeconds(duration)
                
                self.sliderLenghtTrack.value = Float(currentTime / durationSeconds)
            }
        }
    }
    
    private func statusPlay() {
        if status == true {
            playButton.setImage(UIImage(systemName:"pause.fill"), for: .normal)
            player.play()
        } else {
            playButton.setImage(UIImage(systemName:"play.fill"), for: .normal)
            player.pause()
        }
    }
    
    @objc private func volumeTrack() {
        player.volume = sliderVolumeTrack.value
    }
    
    @objc private func tapPlayButton() {
        if player.timeControlStatus == .playing {
            player.pause()
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            player.play()
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    @objc private func sliderLenghtComposition(){
        if let duration = player.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(sliderLenghtTrack.value) * totalSeconds
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            player.seek(to: seekTime, completionHandler: { (completedSeek) in
            })
        }
    }
    
    @objc private func playerItemDidPlayToEndTime() {
        player.play()
        playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    @objc private func tapNextTrack() {
        player.pause()
        if currentTrack == modelSong.count + 1 {
            currentTrack = 0
        } else {
            currentTrack += 1
        }
        
        if currentTrack != modelSong.count{
            configure(with: modelSong[currentTrack])
            guard let url = modelSong[currentTrack].playTrack else { return }
            playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            sliderUpdateValue()
            statusPlay()
        }
    }
    
    @objc private func tapPreviousTrack() {
        player.pause()
        if currentTrack != 0 {
            currentTrack -= 1
        } else {
            currentTrack = modelSong.endIndex
        }
        configure(with: modelSong[currentTrack])
        guard let url = modelSong[currentTrack].playTrack else { return }
        playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        sliderUpdateValue()
        statusPlay()
        
    }
    
}

//MARK: extension

extension MusicPlayerViewController {
    
    private func configure(with viewModel: CellViewModelSong) {
        nameAuthor.text = viewModel.nameAvtor
        nameTrack.text = viewModel.nameSong
        
        if let data = viewModel.imageData {
            musicImage.image = UIImage(data: data)
        } else if let url = viewModel.imageSong {
            URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
                guard let data = data, error == nil else { return }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.musicImage.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
    private func setupView() {
        view.addSubview(musicImage)
        view.addSubview(sliderLenghtTrack)
        view.addSubview(sliderVolumeTrack)
        view.addSubview(playButton)
        view.addSubview(nextTrack)
        view.addSubview(previousTrack)
        view.addSubview(nameTrack)
        view.addSubview(nameAuthor)
        view.addSubview(volumeLabel)
        view.addSubview(trackLengthLabel)
        view.addSubview(trackPassedLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            musicImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            musicImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            musicImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            musicImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -500)
        ])
        
        NSLayoutConstraint.activate([
            sliderLenghtTrack.topAnchor.constraint(equalTo: musicImage.bottomAnchor, constant: 50),
            sliderLenghtTrack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sliderLenghtTrack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            sliderVolumeTrack.topAnchor.constraint(equalTo: volumeLabel.bottomAnchor, constant: 15),
            sliderVolumeTrack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            sliderVolumeTrack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            trackLengthLabel.widthAnchor.constraint(equalToConstant: 45),
            trackLengthLabel.heightAnchor.constraint(equalToConstant: 24),
            trackLengthLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            trackLengthLabel.topAnchor.constraint(equalTo: sliderLenghtTrack.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            trackPassedLabel.widthAnchor.constraint(equalToConstant: 45),
            trackPassedLabel.heightAnchor.constraint(equalToConstant: 24),
            trackPassedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            trackPassedLabel.topAnchor.constraint(equalTo: sliderLenghtTrack.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameTrack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTrack.centerYAnchor.constraint(equalTo: sliderLenghtTrack.bottomAnchor, constant: 70)
        ])
        
        NSLayoutConstraint.activate([
            nameAuthor.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameAuthor.centerYAnchor.constraint(equalTo: nameTrack.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            volumeLabel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 15),
            volumeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            playButton.heightAnchor.constraint(equalToConstant: 50),
            playButton.widthAnchor.constraint(equalToConstant: 50),
            playButton.topAnchor.constraint(equalTo: nameAuthor.bottomAnchor, constant: 60),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nextTrack.heightAnchor.constraint(equalToConstant: 50),
            nextTrack.widthAnchor.constraint(equalToConstant: 50),
            nextTrack.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 10),
            nextTrack.topAnchor.constraint(equalTo: nameAuthor.bottomAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            previousTrack.heightAnchor.constraint(equalToConstant: 50),
            previousTrack.widthAnchor.constraint(equalToConstant: 50),
            previousTrack.rightAnchor.constraint(equalTo: playButton.leftAnchor, constant: -10),
            previousTrack.topAnchor.constraint(equalTo: nameAuthor.bottomAnchor, constant: 60)
        ])
        
    }
}
