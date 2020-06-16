//
//  CheckBoxView.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 16..
//  Copyright © 2020. Student. All rights reserved.
//
import SwiftUI

struct CheckBoxView: View {
    @State var isChecked :Bool = false
    var body: some View {
        Button(action:{
            self.isChecked.toggle()
        }) {
            Image(systemName: isChecked ? "checkmark.square": "square")
            .padding(5)
        }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView()
    }
}
