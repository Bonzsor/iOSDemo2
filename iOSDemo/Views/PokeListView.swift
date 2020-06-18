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
    
    @State var refreshList = false
    
    var body: some View {
        NavigationView {
            List(someVM.filteredList()){ element in NavigationLink(destination: InfoView(infoVM: element.infoVM, refreshList: self.$refreshList)
                ){
                    HStack{
                        Text(element.name).foregroundColor((element.infoVM.isCatched ? .green : .black))
                    }.accentColor(self.refreshList ? .white : .white)
                    
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
