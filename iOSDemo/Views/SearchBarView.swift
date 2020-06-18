//
//  SearchBarView.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 16..
//  Copyright © 2020. Student. All rights reserved.
//

import SwiftUI
 
struct SearchBarView: View {
    //Reactive searchbar
    
    //ViewModel for Type and Pokemon handling
    @ObservedObject var someVM: ViewModel
 
    var body: some View
    {
        TextField("Search Pokemon", text: $someVM.searchText)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
    }
}


struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(someVM: ViewModel())
    }
}
