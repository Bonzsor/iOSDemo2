//
//  CheckBoxView.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 16..
//  Copyright © 2020. Student. All rights reserved.
//
import SwiftUI

struct CheckBoxView: View {
    @ObservedObject var someVM: ViewModel
    
    var body: some View {
        Button(action:{
            self.someVM.isFiltered.toggle()
        }) {
            Image(systemName: self.someVM.isFiltered ? "checkmark.square": "square")
            .padding(5)
        }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(someVM: ViewModel())
    }
}
