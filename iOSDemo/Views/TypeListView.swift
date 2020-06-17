//
//  TypeListView.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 16..
//  Copyright © 2020. Student. All rights reserved.
//

import SwiftUI

struct TypeListView: View {
    
    @ObservedObject var someVM: ViewModel
    
    @State private var selectedType = 0
    
    
    
    var body: some View {
        VStack{
            NavigationView {
                        Picker(selection: $selectedType, label: Text("Type")) {
                            ForEach(someVM.typeElements, id: \.self.id){element in Text(element.name)}
            
                        }.navigationBarTitle("Select your type")
            }
            Button(action:{
                self.someVM.fetchPokemons(selectedType: self.selectedType)
                self.someVM.start = false
            }){
                Text("Choose")
            }
            Spacer()
        }
        
        
    }
}


struct TypeListView_Previews: PreviewProvider {
    static var previews: some View {
        TypeListView(someVM: ViewModel())
    }
}
