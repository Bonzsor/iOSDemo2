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
    
    var body: some View {
        NavigationView {
            List(someVM.filteredList()){ element in NavigationLink(destination: VStack{
                    Image(uiImage: UIImage(data: self.someVM.getImage(pokeUrl: element.url)) ?? UIImage())
                    HStack{
                        Text("Name: ")
                        Text(element.name)
                    }
                    HStack{
                        Text("Height: ")
                        Text(String(self.someVM.pData.height))
                    }
                    HStack{
                        Text("Weight: ")
                        Text(String(self.someVM.pData.weight))
                    }
                    HStack{
                        Text("Abilities: ")
                    }
                    Button(action:{
                        //element.isCatched.toggle()
                    }){
                        if(element.isCatched){
                            Text("Release")
                        }else{
                            Text("Catch")
                        }
                    }
                
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
