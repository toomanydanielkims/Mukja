//
//  ItemDetail.swift
//  Mukja
//
//  Created by Daniel Kim on 8/23/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI

struct ItemDetail: View {
    
    var item: ShoppingItem = shoppingList[0]
    
    var body: some View {
        List {
            VStack(spacing: 20.0) {
                Image(item.title)
                .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                Text(item.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationBarTitle(item.title)
        }
    .listStyle(GroupedListStyle())
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetail()
    }
}
