//
//  PokeListView.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 16..
//  Copyright © 2020. Student. All rights reserved.
//

import SwiftUI

struct PokeListView: View {
    @ObservedObject var PokeListVM = ListViewModel(apiUrl: "")
    
    var body: some View {
        ScrollView{
            
            ForEach(PokeListVM.elements){element in Text(element.name)}
        }
    }
}

struct PokeListView_Previews: PreviewProvider {
    static var previews: some View {
        PokeListView()
    }
}
