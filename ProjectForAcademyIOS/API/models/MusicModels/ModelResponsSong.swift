//
//  ModelResponsSong.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 19.05.2022.
//

import Foundation

class CellViewModelSong {
    var imageData: Data? = nil
    let imageSong: URL?
    let nameSong: String
    let nameAvtor: String
    let playTrack: URL?

    init(nameSong: String, nameAvtor: String, imageSong: URL, playTrack: URL) {
        self.nameSong = nameSong
        self.nameAvtor = nameAvtor
        self.imageSong = imageSong
        self.playTrack = playTrack
    }
}
