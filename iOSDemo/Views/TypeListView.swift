//
//  TypeListView.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 16..
//  Copyright © 2020. Student. All rights reserved.
//

import SwiftUI

struct TypeListView: View {
    //Type chooser UI
    
    //ViewModel for Type and Pokemon handling
    @ObservedObject var someVM: ViewModel
    
    //State value for the type picker
    //TODO: get one of the values from the API
    @State private var selectedType = "normal"

    var body: some View
    {
        VStack{
            NavigationView {
                Picker(selection: $selectedType, label: Text("Type")) {
                    ForEach(someVM.chooseableTypes, id: \.self){element in
                        HStack{
                            Text(element)
                        }
                    }
                }.id(self.someVM.chooseableTypes).navigationBarTitle("Select your type").padding(20)
            }
            Button(action:{
                //fetching the pokemon data, and enable the loading overlay
                self.someVM.fetchPokemons(selectedType: self.selectedType)
            }){
                Text("Choose")
            }
        }
    }
}


struct TypeListView_Previews: PreviewProvider {
    static var previews: some View {
        TypeListView(someVM: ViewModel())
    }
}
