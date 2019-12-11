//
//  PokemonData.swift
//  PokemonCards
//
//  Created by Brendon Cecilio on 12/10/19.
//  Copyright © 2019 Brendon Cecilio. All rights reserved.
//

import Foundation

struct PokemonCards: Decodable {
    let cards: [Cards]
}

struct Cards: Decodable {
    let name: String
    let imageUrl: String
    let types: [String]
    let set: String
    let weakness: [Weakness]
}

struct Weakness: Decodable {
    let type: String
}
