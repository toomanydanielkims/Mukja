//
//  TabBar.swift
//  Mukja
//
//  Created by Daniel Kim on 8/24/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            ContentView().tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
            }
            MealPlannerView().tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Meal Planner")
            }
        }
    
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBar().previewDevice("iPhone 8")
            TabBar().previewDevice("iPhone 11 Pro ")
        }
    }
}
