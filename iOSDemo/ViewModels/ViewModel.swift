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
    var infoVM: InfoViewModel
}




class ViewModel: ObservableObject {
    
    //Constant Values
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    //API url
    let typeUrl = "https://pokeapi.co/api/v2/type/"
    
    //Main screen state values
    
    //Starting UI bool
    var start: Bool = true {
        willSet {
            objectWillChange.send()
        }
    }
    
    //Loading overlay shower
    var loading: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    
    //Type API json decoded values
    var typeElements = [TypeElement]()
    var chooseableTypes = [String]()
    
    
    //Pokemon list API json decoded values
    var pokeElements = [PokeElement]()
    var catchElements = [CatchableElement]()
    
    //Searching header variables
    var searchText: String = "" {
        willSet {
            objectWillChange.send()
        }
    }
    var isFiltered: Bool = false {
        willSet {
            objectWillChange.send()
        }
    }
    
    
    init() {
        // fetch Type API json and decode and update some array property
        guard let url = URL(string: typeUrl) else {return}
        
        if let data = try? Data(contentsOf: url) {
            if let jsonElements = try? JSONDecoder().decode(TypeElements.self, from: data){
                self.typeElements = jsonElements.results
                for element in self.typeElements {
                    chooseableTypes.append(element.name)
                }
            }
        }
    }
    
    func fetchPokemons(selectedType: String) {
        // fetch Pokemon API json and decode and update some array property
        
        self.loading = true
        
        //Run in a background thread
        let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
        dispatchQueue.async{
            var tmpUrl = ""
            //find the url for the choosed name
            for element in self.typeElements {
                if element.name == selectedType {
                    tmpUrl = element.url
                    break
                }
            }
            //fetch, decode, update
            guard let url = URL(string: tmpUrl) else {return}
            if let data = try? Data(contentsOf: url) {
                if let jsonElements = try? JSONDecoder().decode(PokeElements0.self, from: data){
                    let tmpPoke = jsonElements.pokemon
                    for pokeElements1 in tmpPoke {
                        self.pokeElements.append(pokeElements1.pokemon)
                    }
                }
            }
            //TODO: eliminate double for
            for pokemon in self.pokeElements {
                self.catchElements.append(CatchableElement(name: pokemon.name, infoVM: InfoViewModel(pokeUrl: pokemon.url)))
            }
            
        }
        //wait for the loading task
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.loading = false
            self.start = false
        }
    }
    
    func filteredList() -> [CatchableElement]{
        //Filter the Pokemon list, with search or catched filter
        
        var filteretedElemets = [CatchableElement]()
        if(self.isFiltered){
            if(self.searchText != ""){
                for pokemon in self.catchElements{
                    if(pokemon.name == self.searchText && pokemon.infoVM.isCatched){
                        filteretedElemets.append(pokemon)
                    }
                }
            }else{
                for pokemon in self.catchElements{
                    if(pokemon.infoVM.isCatched){
                        filteretedElemets.append(pokemon)
                    }
                }
            }
        }else{
            if(self.searchText != ""){
                for pokemon in self.catchElements{
                    if(pokemon.name == self.searchText){
                        filteretedElemets.append(pokemon)
                    }
                }
            }else{
                return self.catchElements
            }
        }
        return filteretedElemets
    }
    
}
