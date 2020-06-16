//
//  ListViewModel.swift
//  iOSDemo
//
//  Created by Student on 2020. 06. 16..
//  Copyright © 2020. Student. All rights reserved.
//

import Foundation

class ListViewModel: ObservableObject {
    struct Elements: Codable{
        let results: [Element]
    }

    struct Element: Identifiable, Codable {
        let id = UUID()
        let name: String
        let url: String
    }
    
    @Published var elements = [Element]()
    
    init(apiUrl: String) {
        // fetch json and decode and update some array property
        guard let url = URL(string: apiUrl) else {return}
        
        if let data = try? Data(contentsOf: url) {
            if let jsonElements = try? JSONDecoder().decode(Elements.self, from: data){
                self.elements = jsonElements.results
                print("data")
            }
        }
        
        
            
        
    }
}
