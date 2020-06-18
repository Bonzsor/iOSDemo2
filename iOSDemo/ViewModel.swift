//
//  ViewModel.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 17..
//  Copyright © 2020. Student. All rights reserved.
//

import Foundation
import Combine

//Type Decoding Structs

struct TypeElements: Codable{
    let results: [TypeElement]
}

struct TypeElement: Identifiable, Codable {
    let id = UUID()
    let name: String
    let url: String
}

//Pokemon Decoding Structs

struct PokeElements0: Codable{
    let pokemon: [PokeElements1]
}
struct PokeElements1: Codable{
    let pokemon: PokeElement
}

struct PokeElement: Codable {
    let name: String
    let url: String
}

struct CatchableElement: Identifiable {
    let id = UUID()
    var name: String
    let url: String
    var isCatched: Bool = false
}

//Pokemon Info Decoding Structs

struct PokeInfos: Codable {
    let abilities: [AbilityElement]
    let height: Int
    let sprites: Sprites
    let weight: Int
}

struct AbilityElement: Codable {
    let ability: AbilityAbility
    let isHidden: Bool
}

struct AbilityAbility: Codable {
    let name: String
}
 
struct Sprites: Codable {
    let frontDefault: String
}

// Pokemon info final struct

struct PokemonData: Identifiable {
    let id = UUID()
    let abilities: [String]
    let height: Int
    let weight: Int
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
    var catchElements = [CatchableElement]()
    
    var pData =  PokemonData(abilities: [], height: 0,weight: 0)
    
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
                let tmpPoke = jsonElements.pokemon
                for pokeElements1 in tmpPoke {
                    pokeElements.append(pokeElements1.pokemon)
                }
            }
        }
        //TODO: eliminate double for
        for pokemon in pokeElements {
            catchElements.append(CatchableElement(name: pokemon.name, url: pokemon.url))
        }
    }
    
    func filteredList() -> [CatchableElement]{
        if(self.searchText == ""){
            return self.catchElements
        }
        var filteretedElemets = [CatchableElement]()
        for pokemon in self.catchElements{
            if(pokemon.name == self.searchText){
                filteretedElemets.append(pokemon)
            }
        }
        return filteretedElemets
        
    }
    
    func getImage(pokeUrl: String) -> Data{
        
        var imageUrl = ""
        
        guard let url = URL(string: pokeUrl) else {return Data()}
        print(url)
        if let data = try? Data(contentsOf: url) {
            if let jsonElements = try? JSONDecoder().decode(PokeInfos.self, from: data){
                var abilities = [String]()
                for element in jsonElements.abilities{
                    if(!element.isHidden){
                        abilities.append(element.ability.name)
                    }
                }
                self.pData = PokemonData(abilities: abilities, height: jsonElements.height, weight: jsonElements.weight)
                imageUrl = jsonElements.sprites.frontDefault
                print(imageUrl)
            }
        }
        
        
        
        
        
        var imData = Data()
        guard let iUrl = URL(string: imageUrl) else {return Data()}
        let task = URLSession.shared.dataTask(with: iUrl) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                imData = data
            }
        }
        task.resume()
        
        return imData
    }
    
}
