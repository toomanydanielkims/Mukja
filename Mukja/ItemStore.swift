//
//  ItemStore.swift
//  Mukja
//
//  Created by Daniel Kim on 8/26/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI
import Combine

class ItemStore: ObservableObject {
    
    //main list
    @Published var shoppingItems: [ShoppingItem] = shoppingList {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try?
                encoder.encode(shoppingItems) {
                    UserDefaults.standard.set(encoded, forKey: "ShoppingItems")
                }
        }
    }
    init() {
        if let shop = UserDefaults.standard.data(forKey: "ShoppingItems") {
            let decoder = JSONDecoder()
            if let decoded = try?
                decoder.decode([ShoppingItem].self, from: shop) {
                self.shoppingItems = decoded
                return
            }
        }
        self.shoppingItems = []
    }
        
    //for shopping runs
    @Published var run = [ShoppingItem]()
    
    func add(item: ShoppingItem) {
        run.append(item)
    }
    func remove(item: ShoppingItem) {
        if let index = run.firstIndex(of: item) {
            run.remove(at: index)
        }
    }
}


struct ShoppingItem: Identifiable, Codable, Equatable {
    var id = UUID()
    var title: String
    var suggester: String
    var selected: Bool
    var count: Int
    var counter: String
    var image = "food"
    var store = "none"
}

let shoppingList = [
    ShoppingItem(title: "celery", suggester: "mom", selected: false, count: 2, counter: "bundles"),
    ShoppingItem(title: "pasta", suggester: "sister", selected: false, count: 4, counter: "packs"),
    ShoppingItem(title: "water", suggester: "me", selected: false, count: 24, counter: "bottles")
    
]



struct ItemStore_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
