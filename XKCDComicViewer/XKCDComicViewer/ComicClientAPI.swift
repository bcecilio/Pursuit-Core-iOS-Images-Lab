//
//  ComicClient.swift
//  XKCDComicViewer
//
//  Created by Brendon Cecilio on 12/10/19.
//  Copyright © 2019 Brendon Cecilio. All rights reserved.
//

import Foundation

struct ComicBookAPI {
    
    static func getComics(with ComicNum: Int, completion: @escaping (Result<ComicBooks, AppError>) -> ()) {
        
        let urlComic = "https://xkcd.com/\(ComicNum)/info.0.json"
        
        NetworkHelper.shared.performDataTask(with: urlComic) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let comicData = try JSONDecoder().decode(ComicBooks.self, from: data)
                    _ = comicData
                    completion(.success(comicData))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
