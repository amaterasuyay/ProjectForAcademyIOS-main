//
//  ApiManager.swift
//  ProjectForAcademyIOS
//
//  Created by Nikita on 15.04.2022.
//

import Foundation

enum ApiType {
    
    case recommendations
    case song
    
    var baseURL: String {
        return "https://shazam.p.rapidapi.com/"
    }
    
    var headers: [String: String] {
        [   "X-RapidAPI-Host": "shazam.p.rapidapi.com",
            "X-RapidAPI-Key": "af67c15e68mshf7a987aaeaa6292p113676jsna3fbee5c9c2d"]
    }
    
    var path: String {
        switch self {
        case .recommendations: return "ist-recommendations?key=484129036&locale=en-US"
        case .song: return "songs/list-artist-top-tracks?id=40008598&locale=en-US"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: URL(string: baseURL)!)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        switch self {
        case .recommendations:
            request.httpMethod = "GET"
            return request
        case .song:
            request.httpMethod = "GET"
            return request
        }
        
    }
}

final class ApiManager {
    
    static let shared = ApiManager()
    
    func getRequestNews(completion: @escaping (Result<[Article], Error>) -> Void) {
        
        let apiKey = "ea35ac5a899a13551f67435ce50787ce"
        let url = URL(string: "https://gnews.io/api/v4/top-headlines?token=\(apiKey)")
        guard let doneUrl = url else { return }
        
        let task = URLSession.shared.dataTask(with: doneUrl) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do  {
                    let result = try JSONDecoder().decode(News.self, from: data)
                    print(result)
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func getRequestSong(completion: @escaping (Result<[Track], Error>) -> Void) {
        
        let request = ApiType.song.request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(Welcome.self, from: data)
                    print(result)
                    completion(.success((result.tracks ?? [])))
                }
                catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
}
