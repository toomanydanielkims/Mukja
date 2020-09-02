//
//  TabBar.swift
//  Mukja
//
//  Created by Daniel Kim on 8/24/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    
    @State var tabSelection = 1
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ContentView(tabSelection: $tabSelection).tabItem {
                Image(systemName: "play.circle.fill")
                Text("Home")
            }.tag(1)
            
            MealPlannerView(tabSelection: $tabSelection).tabItem {
                Image(systemName: "rectangle.stack.fill")
                Text("Meal Planner")
            }.tag(2)
            
            ShoppingView(tabSelection: $tabSelection).tabItem {
                Image(systemName: "rectangle.stack")
                Text("Shopping")
            }.tag(3)
            
           SwipeView(tabSelection: $tabSelection).tabItem {
                Image(systemName: "rectangle.stack")
                Text("Meal Swiper")
            }.tag(4)
            
            PickedMealsView(tabSelection: $tabSelection).tabItem {
                Image(systemName: "rectangle.stack")
                Text("Picked Meals")
            }.tag(5)
    }
}
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TabBar().previewDevice("iPhone 11")
        }
    }
}
