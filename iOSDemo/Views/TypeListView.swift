//
//  TypeListView.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 16..
//  Copyright © 2020. Student. All rights reserved.
//

import SwiftUI

struct TypeListView: View {
    
    @ObservedObject var TypeListVM = ListViewModel(apiUrl: "https://pokeapi.co/api/v2/type/")
    
    @State private var selectedType = 0
    
    
    
    var body: some View {
        VStack{
            NavigationView {
                        Picker(selection: $selectedType, label: Text("Type")) {
                            ForEach(TypeListVM.elements){element in Text(element.name)}
            
                }.navigationBarTitle("Select your type")
            }
            Button(action:{
                //TODO
            }){
                Text("Choose")
            }
        }
        
        
    }
}


struct TypeListView_Previews: PreviewProvider {
    static var previews: some View {
        TypeListView()
    }
}
