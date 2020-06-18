//
//  ContentView.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 16..
//  Copyright © 2020. Student. All rights reserved.
//

import SwiftUI
import Combine



struct ContentView: View {
    //Main View with a type and pokemonlist option and with a loading overlay
    
    //ViewModel for Type and Pokemon handling
    @ObservedObject var someVM = ViewModel()
    
    var body: some View
    {
        //Loading overlay
        LoadingView(isShowing: self.$someVM.loading) {
            VStack{
                if(self.someVM.start){
                    //Type chooser
                    TypeListView(someVM: self.someVM)
                    Spacer()
                }else{
                    HStack{
                        // Searching header
                        SearchBarView(someVM: self.someVM)
                        CheckBoxView(someVM: self.someVM)
                        .padding(10)
                    }
                    //Pokemon list
                    PokeListView(someVM: self.someVM)
                }
            }
        }
    }
}
