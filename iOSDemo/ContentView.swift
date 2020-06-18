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
    @ObservedObject var someVM = ViewModel()
    
    var body: some View
    {
        VStack{
            if(someVM.start){
                TypeListView(someVM: someVM)
                Spacer()
            }else{
                HStack{
                    SearchBarView(someVM: someVM)
                    CheckBoxView(someVM: someVM)
                    .padding(10)
                }
                PokeListView(someVM: someVM)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
