//
//  ShoppingRunView.swift
//  Mukja
//
//  Created by Daniel Kim on 8/26/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI

struct ShoppingRunView: View {
    @EnvironmentObject var itemStore: ItemStore
    
    @State private var showOrder = false
    
    var colorLevel : Color {
        didSet {
            colorLevel = Color(#colorLiteral(red: 0.003921568627, green: 0.6509803922, blue: 0.4431372549, alpha: 1))
            return
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    HStack {
                        Spacer()
                        Button("done shopping") {
                            self.showOrder.toggle()
                        }
                        .frame(width: 150, height:60)
                        .background(Color(.white)).cornerRadius(10).foregroundColor(Color(#colorLiteral(red: 0.003921568627, green: 0.6509803922, blue: 0.4431372549, alpha: 1))).font(.headline)
                        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1).shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 12)
                        .disabled(itemStore.run.isEmpty)
                        Spacer()
                    }
                    .frame(height: 100)
                    
                    ForEach(itemStore.run) { item in
                        HStack {
                            Spacer(); Text(item.title).foregroundColor(self.colorLevel); Spacer()
                        }
                    }
                .onDelete(perform: deleteItems)
                .onMove { (source: IndexSet, destination: Int) in
                    self.itemStore.run.move(fromOffsets: source, toOffset: destination) }
            }
            .buttonStyle(PlainButtonStyle())
            .navigationBarTitle(Text("Shopping Run"))
            .navigationBarItems(trailing: EditButton())
            .alert(isPresented: $showOrder) {
                Alert(title: Text("Your hashtags are copied"), message: Text("\(UIPasteboard.general.string!)"), dismissButton: .default(Text("Done"))) }
            }
    }
            .background(Color(#colorLiteral(red: 0.003921568627, green: 0.6509803922, blue: 0.4431372549, alpha: 1)))
        .onAppear { UITableView.appearance().separatorStyle = .none }
}
    func deleteItems(at offsets: IndexSet) {
        itemStore.run.remove(atOffsets: offsets) }
}



struct ShoppingRunView_Previews: PreviewProvider {
    static let itemStore = ItemStore()
    static var previews: some View {
        ShoppingRunView(colorLevel: Color(#colorLiteral(red: 0.003921568627, green: 0.6509803922, blue: 0.4431372549, alpha: 1))).environmentObject(itemStore)
    }
}
