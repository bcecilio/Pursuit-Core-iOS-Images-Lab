//
//  PokemonCardAPI.swift
//  PokemonCards
//
//  Created by Brendon Cecilio on 12/10/19.
//  Copyright © 2019 Brendon Cecilio. All rights reserved.
//

import Foundation

struct PokemonCardAPI {
    static func getCards(with urlString: String, completion: @escaping (Result<Cards, AppError>) -> ()) {
        
        let urlCards = "https://api.pokemontcg.io/v1/cards"
        
        NetworkHelper.shared.performDataTask(with: urlCards) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let cardData = try JSONDecoder().decode(Cards.self, from: data)
                    let cards = cardData
                    completion(.success(cards))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
