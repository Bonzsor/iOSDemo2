//
//  PokeListViewModel.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 16..
//  Copyright © 2020. Student. All rights reserved.
//

import Foundation

class PokeListViewModel: ObservableObject {
    struct Pokemons: Codable{
        let results: [Pokemon]
    }

    struct Pokemon: Identifiable, Codable {
        let id = UUID()
        let name: String
        let url: String
        let isCatched :Bool = false
    }
    
    let apiUrl = "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=964"
    
    @Published var pokemons = [Pokemon]()
    
    init() {
        // fetch json and decode and update some array property
        guard let url = URL(string: apiUrl) else {return}
        
        if let data = try? Data(contentsOf: url) {
            if let jsonPokemons = try? JSONDecoder().decode(Pokemons.self, from: data){
                self.pokemons = jsonPokemons.results
            }
        }
    }
}
