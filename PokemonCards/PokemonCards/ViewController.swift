//
//  ViewController.swift
//  PokemonCards
//
//  Created by Brendon Cecilio on 12/6/19.
//  Copyright © 2019 Brendon Cecilio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var pokemonInfo = [PokemonCards]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func loadData(urlString: String) {
        let pokemon = PokemonCardAPI.getCards(with: urlString) { (result) in
            switch result {
            case .failure(let appError):
                print("\(appError)")
            case .success(let pokemonData):
                DispatchQueue.main.async{
                    
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath)
        
        let pokemonCell = pokemonInfo[indexPath.row]
        cell.textLabel?.text = pokemonCell.
        return cell
    }
    
    
}
