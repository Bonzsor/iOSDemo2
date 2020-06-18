//
//  InfoViewModel.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 18..
//  Copyright © 2020. Student. All rights reserved.
//

import Foundation
import Combine

//Pokemon Info Decoding Structs

struct PokeInfos: Codable {
    let abilities: [AbilityElement]
    let height: Int
    let sprites: Sprites
    let weight: Int
    let name: String
}

struct AbilityElement: Codable {
    let ability: AbilityAbility
    let isHidden: Bool
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
    }
}

struct AbilityAbility: Codable {
    let name: String
}
 
struct Sprites: Codable {
    let frontDefault: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// Pokemon info final struct

struct PokemonData: Identifiable {
    let id = UUID()
    let abilities: [String]
    let height: Int
    let weight: Int
    let name: String
}

class InfoViewModel: ObservableObject{
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    //Loaded Image value
    var imData = Data()
    
    //Pokemon infos
    var pData =  PokemonData(abilities: [], height: 0,weight: 0, name: "none")
    
    //Catched state value
    var isCatched: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    init(pokeUrl: String){
        // fetch Pokemon Information API json and decode and update some array property
        
        var imageUrl = ""
        
        guard let url = URL(string: pokeUrl) else {return}
        if let data = try? Data(contentsOf: url) {
            if let jsonElements = try? JSONDecoder().decode(PokeInfos.self, from: data){
                var abilities = [String]()
                for element in jsonElements.abilities{
                    if(!element.isHidden){
                        abilities.append(element.ability.name)
                    }
                }
                self.pData = PokemonData(abilities: abilities, height: jsonElements.height, weight: jsonElements.weight, name: jsonElements.name)
                imageUrl = jsonElements.sprites.frontDefault
            }
        }
        
        //fetching the pokemon image
        guard let iUrl = URL(string: imageUrl) else {return}
        let task = URLSession.shared.dataTask(with: iUrl) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.imData = data
            }
        }
        task.resume()
    }
}
