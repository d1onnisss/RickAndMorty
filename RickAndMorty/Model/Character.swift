//
//  Model.swift
//  RickAndMorty
//
//  Created by Alexey Lim on 21/9/24.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let image: String?
}

struct RickAndMortyResponse: Codable {
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

