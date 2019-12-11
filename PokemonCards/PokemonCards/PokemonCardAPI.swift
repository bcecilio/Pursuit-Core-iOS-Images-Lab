//
//  PokemonCardAPI.swift
//  PokemonCards
//
//  Created by Brendon Cecilio on 12/10/19.
//  Copyright © 2019 Brendon Cecilio. All rights reserved.
//

import Foundation

struct PokemonCardAPI {
    static func getCards(completion: @escaping (Result<[Cards], AppError>) -> ()) {
        
        let urlCards = "https://api.pokemontcg.io/v1/cards?from=0&to=50"
        
        guard let url = URL(string: urlCards) else {
            completion(.failure(.badURL(urlCards)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let cardData = try JSONDecoder().decode(PokemonCards.self, from: data)
                    completion(.success(cardData.cards))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
