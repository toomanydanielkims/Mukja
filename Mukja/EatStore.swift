//
//  EatStore.swift
//  Mukja
//
//  Created by Daniel Kim on 8/30/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI
import Combine

class EatStore: ObservableObject {
    @Published var eats: [Eat] = eatData
    
        func add(item: Eat) {
            eats.append(item)
        }
        func remove(item: Eat) {
            if let index = eats.firstIndex(of: item) {
                eats.remove(at: index)
            }
        }
    }
    

struct Eat: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var icon: String
    var suggester: String
    var image = "food"
    var color : String
    var date : Date
}

let eatData = [
    Eat(title: "example1", icon: "apple", suggester: "mom", color: "blue", date: Date())

]
