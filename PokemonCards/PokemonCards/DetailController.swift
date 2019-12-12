//
//  DetailController.swift
//  PokemonCards
//
//  Created by Brendon Cecilio on 12/11/19.
//  Copyright © 2019 Brendon Cecilio. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonWeaknessLabel: UILabel!
    @IBOutlet weak var pokemonSetLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    
    var pokemonDetail: Cards?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        updateUI(for: pokemonDetail!)
    }
    
    func updateUI(for pokemon: Cards) {
        guard let pokemonInfo = pokemonDetail else {
            print("no information found!")
            return
        }
        pokemonNameLabel.text = pokemonInfo.name
        pokemonWeaknessLabel.text = pokemonInfo.weakness?.type
        pokemonTypeLabel.text = pokemonInfo.types?.first
        pokemonSetLabel.text = pokemonInfo.set
        pokemonImage.getImage(with: pokemon.imageUrlHiRes ?? "") { (result) in
            switch result {
            case .failure( _):
                print("could not find image")
            case .success(let image):
                DispatchQueue.main.async {
                    self.pokemonImage.image = image
                }
            }
        }
    }
}
