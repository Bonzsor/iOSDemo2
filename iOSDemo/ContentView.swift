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
        LoadingView(isShowing: self.$someVM.loading) {
        VStack{
            if(self.someVM.start){
                TypeListView(someVM: self.someVM)
                Spacer()
            }else{
                HStack{
                    SearchBarView(someVM: self.someVM)
                    CheckBoxView(someVM: self.someVM)
                    .padding(10)
                }
                PokeListView(someVM: self.someVM)
            }
            
            }
            
        }
    }
}
