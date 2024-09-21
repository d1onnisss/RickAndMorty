//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Alexey Lim on 21/9/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private let baseURL = "https://rickandmortyapi.com/api/character"
    
    func fetchCharacters(completion: @escaping ([Character]?) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode([String: [Character]].self, from: data)
                completion(result["results"])
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
}
