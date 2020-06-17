//
//  PokeListView.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 16..
//  Copyright © 2020. Student. All rights reserved.
//

import SwiftUI

struct PokeListView: View {
    @ObservedObject var someVM: ViewModel
    
    @State var selector = 0
    
    var body: some View {
        NavigationView {
            List(someVM.filteredList()){ element in NavigationLink(destination: VStack{
                Text(element.name)
                }
            
            
            
            
            ){
                Text(element.name)
                }
            }
            
        }
    }
}

struct PokeListView_Previews: PreviewProvider {
    static var previews: some View {
        PokeListView(someVM: ViewModel())
    }
}
