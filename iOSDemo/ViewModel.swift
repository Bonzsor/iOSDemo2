//
//  ViewModel.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 17..
//  Copyright © 2020. Student. All rights reserved.
//

import Foundation
import Combine


struct TypeElements: Codable{
    let results: [TypeElement]
}

struct TypeElement: Identifiable, Codable {
    let id = UUID()
    let name: String
    let url: String
}

struct PokeElements0: Codable{
    let pokemon: [PokeElements1]
}
struct PokeElements1: Codable{
    let pokemon: PokeElement
}

struct PokeElement: Identifiable, Codable {
    let id = UUID()
    let name: String
    let url: String
    
    //Only for pokemons
    let isCatched :Bool = false
}

class ViewModel: ObservableObject {
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    let typeUrl = "https://pokeapi.co/api/v2/type/"
    
    var start: Bool = true {
        willSet {
            objectWillChange.send()
        }
    }
    
    var typeElements = [TypeElement]()
    
    var pokeElements = [PokeElement]()
    
    var searchText: String = "" {
        willSet {
            objectWillChange.send()
        }
    }
    
    
    init() {
        // fetch json and decode and update some array property
        guard let url = URL(string: typeUrl) else {return}
        
        if let data = try? Data(contentsOf: url) {
            if let jsonElements = try? JSONDecoder().decode(TypeElements.self, from: data){
                self.typeElements = jsonElements.results
            }
        }
    }
    
    func fetchPokemons(selectedType: Int) {
        // fetch json and decode and update some array property
        guard let url = URL(string: self.typeElements[selectedType].url) else {return}
        print(url)
        if let data = try? Data(contentsOf: url) {
            if let jsonElements = try? JSONDecoder().decode(PokeElements0.self, from: data){
                print(data)
                let tmpPoke = jsonElements.pokemon
                for pokeElements1 in tmpPoke {
                    pokeElements.append(pokeElements1.pokemon)
                }
            }
        }
    }
    
    func filteredList() -> [PokeElement]{
        if(self.searchText == ""){
            return self.pokeElements
        }
        var filteretedElemets = [PokeElement]()
        for pokemon in self.pokeElements{
            if(pokemon.name == self.searchText){
                filteretedElemets.append(pokemon)
            }
        }
        return filteretedElemets
        
    }
}
