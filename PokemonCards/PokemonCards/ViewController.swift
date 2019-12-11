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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonInfo = [Cards](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet {
            DispatchQueue.main.async {
                self.searchBarQuery()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailController = segue.destination as? DetailController, let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        detailController.pokemonDetail = pokemonInfo[indexPath.row]
    }
    
    func loadData() {
        PokemonCardAPI.getCards() { (result) in
            switch result {
            case .failure(let appError):
                print("app error: \(appError)")
            case .success(let pokemonCards):
                self.pokemonInfo = pokemonCards
            }
        }
    }
    
    func searchBarQuery() {
        PokemonCardAPI.getCards { (result) in
            switch result {
                case .failure(let appError):
                print("app error: \(appError)")
            case .success(let pokemonCards):
                DispatchQueue.main.async {
                    for type in pokemonCards {
                    self.pokemonInfo = pokemonCards
                    }
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
        cell.textLabel?.text = pokemonCell.name
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            searchBarQuery()
            loadData()
            return
        }
        searchQuery = searchText
    }
}
