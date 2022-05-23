//
//  SongModel.swift
//  ProjectForAcademyIOS
//
//  Created by Maksom Kolbas on 19.05.2022.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let tracks: [Track]?
}

// MARK: - Track
struct Track: Codable {
    let layout: String?
    let type: TrackType?
    let key, title: String?
    let subtitle: Subtitle?
    let share: Share?
    let images: TrackImages?
    let hub: Hub?
    let artists: [Artist]?
    let url: String?
}

// MARK: - Artist
struct Artist: Codable {
    let id, adamid: String?
}

// MARK: - Hub
struct Hub: Codable {
    let type: HubType?
    let image: String?
    let actions: [Action]?
    let options: [Option]?
    let providers: [Provider]?
    let explicit: Bool?
    let displayname: Displayname?
}

// MARK: - Action
struct Action: Codable {
    let name: Name?
    let type: ActionType?
    let id: String?
    let uri: String?
}

enum Name: String, Codable {
    case apple = "apple"
    case hubApplemusicDeeplink = "hub:applemusic:deeplink"
    case hubDeezerSearchdeeplink = "hub:deezer:searchdeeplink"
    case hubSpotifySearchdeeplink = "hub:spotify:searchdeeplink"
}

enum ActionType: String, Codable {
    case applemusicopen = "applemusicopen"
    case applemusicplay = "applemusicplay"
    case uri = "uri"
}

enum Displayname: String, Codable {
    case appleMusic = "APPLE MUSIC"
}

// MARK: - Option
struct Option: Codable {
    let caption: OptionCaption?
    let actions: [Action]?
    let beacondata: Beacondata?
    let image: String?
    let type: BeacondataType?
    let listcaption: Listcaption?
    let overflowimage: String?
    let colouroverflowimage: Bool?
    let providername: Providername?
}

// MARK: - Beacondata
struct Beacondata: Codable {
    let type: BeacondataType?
    let providername: Providername?
}

enum Providername: String, Codable {
    case applemusic = "applemusic"
    case itunes = "itunes"
}

enum BeacondataType: String, Codable {
    case buy = "buy"
    case typeOpen = "open"
}

enum OptionCaption: String, Codable {
    case buy = "BUY"
    case captionOPEN = "OPEN"
}

enum Listcaption: String, Codable {
    case buyOnITunes = "Buy on iTunes"
    case openInAppleMusic = "Open in Apple Music"
}

// MARK: - Provider
struct Provider: Codable {
    let caption: ProviderCaption?
    let images: ProviderImages?
    let actions: [Action]?
    let type: ProviderType?
}

enum ProviderCaption: String, Codable {
    case openInDeezer = "Open in Deezer"
    case openInSpotify = "Open in Spotify"
}

// MARK: - ProviderImages
struct ProviderImages: Codable {
    let overflow, imagesDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case overflow
        case imagesDefault = "default"
    }
}

enum ProviderType: String, Codable {
    case deezer = "DEEZER"
    case spotify = "SPOTIFY"
}

enum HubType: String, Codable {
    case applemusic = "APPLEMUSIC"
}

// MARK: - TrackImages
struct TrackImages: Codable {
    let background, coverart, coverarthq: String?
    let joecolor: String?
}

// MARK: - Share
struct Share: Codable {
    let subject, text: String?
    let href: String?
    let image: String?
    let twitter: String?
    let html: String?
    let avatar: String?
    let snapchat: String?
}

enum Subtitle: String, Codable {
    case kiNeTikPeulRoUFeatYiruma = "KiNeTik PeulRoU Feat. Yiruma"
    case theDarkTenorFeatYiruma = "The Dark Tenor Feat. Yiruma"
    case yiruma = "Yiruma"
    case yirumaFeatRuvin = "Yiruma Feat. Ruvin"
}

enum TrackType: String, Codable {
    case music = "MUSIC"
}
