//
//  MealDetail.swift
//  Mukja
//
//  Created by Daniel Kim on 8/23/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI

struct MealDetail: View {
    var meal: Meal = mealData[0]
    
    var body: some View {
        List {
            VStack(spacing: 20.0) {
                Image(meal.image)
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Text(meal.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationBarTitle(meal.title)
        }
    .listStyle(GroupedListStyle())
    }
}

struct MealDetail_Previews: PreviewProvider {
    static var previews: some View {
        MealDetail()
    }
}
