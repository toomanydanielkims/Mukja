//
//  ShoppingView.swift
//  Mukja
//
//  Created by Daniel Kim on 8/26/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI

struct ShoppingView: View {
    @ObservedObject var itemStore = ItemStore()
    @EnvironmentObject var order: ItemStore
    @State private var showAlert = false
    @State private var blank = ""
    
    @Binding var tabSelection: Int
    
    func addItem(newItem: String) {
        itemStore.shoppingItems.append(ShoppingItem(title: "new item", suggester: "me", selected: false, count: 0, counter: "packs")
           )
      }
    
    func removeItems(at offsets: IndexSet) {
        itemStore.shoppingItems.remove(atOffsets: offsets)
               }
    
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    TextField("add new hashtag here", text: $blank)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Button(action: {
                        self.addItem(newItem: self.blank)
                        self.blank = ""
                    }, label: {
                        Image(systemName: "plus.square")
                    })
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.trailing, 20)
        
                ForEach(itemStore.shoppingItems) { tag in
                            ItemRow(item: tag)
                            .cornerRadius(10)
//                            .listRowBackground(Color.black)
                        }
                        .onDelete(perform: self.removeItems)
                .onMove { (source: IndexSet, destination: Int) in
                    self.itemStore.shoppingItems.move(fromOffsets: source, toOffset: destination) }
            }
            .buttonStyle(PlainButtonStyle())
            .navigationBarTitle("\(itemStore.run.count) items in upcoming shopping run ")
            //.listStyle(GroupedListStyle())
            .navigationBarItems(trailing: EditButton())
            .onAppear {
                UITableView.appearance().separatorStyle = .none
            }
            .foregroundColor(Color(#colorLiteral(red: 0.003921568627, green: 0.6509803922, blue: 0.4431372549, alpha: 1)))
            
    }
    
}
}


struct ItemRow: View {
    
    @State var colorSelect = false
    
    @EnvironmentObject var order: ItemStore
    
    var item: ShoppingItem
    
    var body: some View {
        HStack {
            Text(item.title)
                .fontWeight(colorSelect ? .bold : .regular)
                .scaleEffect(colorSelect ? 1.2 : 1)
                .animation(.spring())
                
            Spacer()
            Button(action: {
                self.colorSelect ? self.colorSelect.toggle() : self.order.add(item: self.item)
                
                self.colorSelect.toggle()
            }) {
                ZStack {
                    Image(systemName: "plus.square")
                        .scaleEffect(colorSelect ? 0 : 1)
                        .animation(.spring())
                    Image(systemName: "checkmark.seal.fill")
                        .scaleEffect(colorSelect ? 1 : 0)
                        .animation(.spring())
                    
                }
            }
        }
        .frame(height: 5.0)
    .padding(30)
        .foregroundColor(.white)
        .background(self.colorSelect ? LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.003921568627, green: 0.6509803922, blue: 0.4431372549, alpha: 1)), Color(#colorLiteral(red: 0.003921568627, green: 0.6509803922, blue: 0.4431372549, alpha: 1))]), startPoint: .topTrailing, endPoint: .bottomLeading) : LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9450980392, green: 0.7568627451, blue: 0.2039215686, alpha: 1)), Color(#colorLiteral(red: 0.9725490196, green: 0.8862745098, blue: 0.337254902, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

struct ShoppingView_Previews: PreviewProvider {
    static let order = ItemStore()
    
    static var previews: some View {
        ShoppingView(tabSelection: .constant(3)).environmentObject(order)
    }
}
