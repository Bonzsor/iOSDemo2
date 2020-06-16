//
//  PokeTypeViewModel.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 16..
//  Copyright © 2020. Student. All rights reserved.
//

import Foundation

class PokeTypeViewModel: ObservableObject {
    struct Elements0: Codable{
        let pokemon: Elements1
    }
    struct Elements1: Codable{
        let pokemon: [Element]
    }

    struct Element: Identifiable, Codable {
        let id = UUID()
        let name: String
        let url: String
        
        //Only for pokemons
        let isCatched :Bool = false
    }
    
    @Published var elements = [Element]()
    
    init(apiUrl: String) {
        // fetch json and decode and update some array property
        guard let url = URL(string: apiUrl) else {return}
        
        if let data = try? Data(contentsOf: url) {
            print(try! JSONDecoder().decode(Elements0.self, from: data))
            if let jsonElements = try? JSONDecoder().decode(Elements0.self, from: data){
                self.elements = jsonElements.pokemon.pokemon
                print("data")
            }
        }
        print(self.elements)
        
    }
}
