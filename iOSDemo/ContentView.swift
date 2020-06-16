//
//  ContentView.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 16..
//  Copyright © 2020. Student. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var PokeListVM = PokeListViewModel()
    
    var body: some View
    {
        VStack{
            HStack{
                //TODO: remove constant
                SearchBarView(text: .constant(""))
                CheckBoxView()
                .padding(10)
            }
            ScrollView{
                
                ForEach(PokeListVM.pokemons){pokemon in Text(pokemon.name)}
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
