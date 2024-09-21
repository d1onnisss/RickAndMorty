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
    
    func fetchCharacters(page: Int = 1, completion: @escaping ([Character]?) -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character?page=\(page)"
        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(RickAndMortyResponse.self, from: data)
                completion(response.results)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }

}
