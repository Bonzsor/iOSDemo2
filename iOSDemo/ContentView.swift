//
//  ContentView.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 16..
//  Copyright © 2020. Student. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View
    {
        VStack{
            TypeListView()
            
            HStack{
                
                
                //TODO: remove constant
                SearchBarView(text: .constant(""))
                CheckBoxView()
                .padding(10)
            }
            PokeListView()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
