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
    
    var pokemonInfo = [Cards](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadData()
    }
    
    func loadData() {
        PokemonCardAPI.getCards(with: "pokemon") { (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let pokemonCards):
                self.pokemonInfo = [pokemonCards]
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
            cell.textLabel?.text = pokemonCell.name
            return cell
        }
}
