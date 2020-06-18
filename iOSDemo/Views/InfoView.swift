//
//  InfoView.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 18..
//  Copyright © 2020. Student. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    
    @ObservedObject var infoVM: InfoViewModel
    @Binding var refreshList: Bool
    
    var body: some View {
        VStack{
            Image(uiImage: UIImage(data: self.infoVM.imData) ?? UIImage())
            HStack{
                Text("Name: ")
                Text(self.infoVM.pData.name)
            }
            HStack{
                Text("Height: ")
                Text(String(self.infoVM.pData.height))
            }
            HStack{
                Text("Weight: ")
                Text(String(self.infoVM.pData.weight))
            }
            Spacer()
            HStack{
                Text("Abilities: ")
                VStack{
                    ForEach(self.infoVM.pData.abilities, id: \.self){
                        ability in Text(ability)
                    }
                }
            }
            Spacer()
            Button(action:{
                self.infoVM.isCatched.toggle()
                self.refreshList.toggle()
            }){
                self.infoVM.isCatched ? Text("Release") : Text("Catch")
                
            }
            Spacer()
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(infoVM: InfoViewModel(pokeUrl: ""), refreshList: .constant(false))
    }
}
