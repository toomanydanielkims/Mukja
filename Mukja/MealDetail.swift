//
//  MealDetail.swift
//  Mukja
//
//  Created by Daniel Kim on 8/23/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI

struct MealDetail: View {
    
    @ObservedObject var datas = observer1()
    
    var meal: pickeddata1
        
    
        var body: some View {
            List {
                VStack(spacing: 20) {
                    Image(meal.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                    Text(meal.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .navigationBarTitle(meal.name)
            }
            .listStyle(PlainListStyle())
        }
}


//struct MealDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        MealDetail(meal: .constant())
//    }
//}
