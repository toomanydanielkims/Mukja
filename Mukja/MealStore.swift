//
//  MealStore.swift
//  Mukja
//
//  Created by Daniel Kim on 8/23/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI
import Combine

class MealStore: ObservableObject {
    @Published var meals: [Meal] = mealData
}

struct Meal: Identifiable, Codable {
    var id = UUID()
    var title: String
    var icon: String
    var suggester: String
    var image = "food"
    var color : String
}

let mealData = [
    Meal(title: "tomato soup", icon: "image", suggester: "me", color: "ssRed"),
    Meal(title: "brisket", icon: "image", suggester: "mom", color: "ssBlue"),
    Meal(title: "lemon peppered salmon", icon: "image", suggester: "bro", color: "ssYellow")
]
