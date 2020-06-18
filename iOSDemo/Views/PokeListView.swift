//
//  PokeListView.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 16..
//  Copyright © 2020. Student. All rights reserved.
//

import SwiftUI

struct PokeListView: View {
    //Pokemon listing UI
    
    //ViewModel for Type and Pokemon handling
    @ObservedObject var someVM: ViewModel
    
    //State value for the always actual list
    @State var refreshList = false
    
    var body: some View
    {
        NavigationView {
            //All list element has an InfoView
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
