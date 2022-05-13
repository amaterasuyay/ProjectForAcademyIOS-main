//
//  ApiManager.swift
//  ProjectForAcademyIOS
//
//  Created by Nikita on 15.04.2022.
//

import Foundation

final class ApiManager {
    
    static let shared = ApiManager()
    
    func getRequest(completion: @escaping (Result<[Article], Error>) -> Void) {
        
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
}
