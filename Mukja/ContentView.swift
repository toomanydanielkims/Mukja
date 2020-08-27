//
//  ContentView.swift
//  Mukja
//
//  Created by Daniel Kim on 8/22/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            
            ScrollView {
                
                HStack {
                    Spacer()
                    Text("Aug 9")
                        .foregroundColor(Color("ssOrange"))
                    Rectangle()
                        .foregroundColor(Color("ssOrange"))
                        .frame(width: 62, height: 44)
                        .cornerRadius(10)
                        .padding(.leading)
                }
                .padding(.vertical, 44)
                .offset(x: -30, y: -30)
                .zIndex(3)
                
                Color("ssYellow")
                    .frame(width: screen.width, height: (screen.height * 0.45))
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: -225)

                MealCard()
                    .zIndex(3)
                    .offset(y: -400)
                    .onTapGesture {
                        self.isLoading.toggle()
                }
                
                HorizontalScrollView()
                    .offset(y: -375)
                
                ShoppingList()
                    .offset(y: -350)
                
            }
            if isLoading {
                LoadingView()
                animation(.easeInOut)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MealCard: View {
    var body: some View {
        VStack {
            //top portion
            HStack {
                HStack {
                    Circle()
                        .frame(width: 24.0, height: 24.0)
                        .zIndex(2)
                        .foregroundColor(Color("ssOrange"))
                    Circle()
                        .frame(width: 24.0, height: 24.0)
                        .foregroundColor(Color(.systemPink))
                        .offset(x: -20)
                        .zIndex(1)
                    Circle()
                        .frame(width: 24.0, height: 24.0)
                        .foregroundColor(Color(.systemGreen))
                        .offset(x: -40)
                        .zIndex(0)
                }
                Text("are enjoying")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(Color("ssNavy"))
                    .offset(x: -20)
                Spacer()
                Spacer()
            }
            .padding(.top, -25)
            .padding(.horizontal, 40)
                .frame(width: screen.width - 88, height: 100)
            .background(Color(.white))
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .offset(y: 40)
            
            // meal portion
            VStack {
                Text("Pork Ribs")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color.white)
                    .padding(2)
                HStack {
                    Text("at")
                        .font(.system(size: 15, weight: .regular))
                    Text(" 7:30 PM")
                        .font(.system(size: 30, weight: .bold))
                        
                }
                .foregroundColor(Color.white)
                .padding(2)
            }
            .padding()
            .frame(width: screen.width - 88, height: 125)
            .background(Color("ssRed"))
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)).opacity(0.3), radius: 5, x: 0, y: 10 )
        }
    }
}


// MARK: - Horizontal Row

struct MealRowView: View {
    var meal: Meal
    var width: CGFloat = 100
    var height: CGFloat = 100
    
    var body: some View {
        VStack {
            VStack {
                HStack(alignment: .top) {
                    Text("\(meal.title) \ndinner")
                        .font(.title)
                        .frame(width: width, alignment: .leading)
                        .foregroundColor(.white)
    //                Spacer()
    //                Image(meal.icon)
                }

    //            meal.icon
    //                .resizable()
    //                .aspectRatio(contentMode: .fit)
    //                .frame(width: 210)
                Spacer()
            }
            .frame(width: width, height: height)
                .padding()
            .background(Color("ssYellow"))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)).opacity(0.3), radius: 5, x: 0, y: 10 )
        }
        
    }

}

struct HorizontalScrollView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {

            HStack {
                HStack(alignment: .center) {
                    Text("Upcoming Meals >")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color("ssNavy")) }
                Spacer()
            }.frame(width: 300, height: 44)
            
            ScrollView (.horizontal, showsIndicators: true) {
                HStack(spacing: 24.0) {
                    ForEach(mealData) { meal in
                        MealRowView(meal: meal, width: screen.width * 0.25, height: 70)
                    }
                }
                .padding(.bottom, 16)
            }
        }
        .offset(x: 45)
    }
}


// MARK: - Vertical List

struct ShoppingItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var suggester: String
    var selected: Bool
    var count: Int
    var counter: String
    var image = "food"
}

let shoppingList = [
    ShoppingItem(title: "celery", suggester: "mom", selected: false, count: 2, counter: "bundles"),
    ShoppingItem(title: "pasta", suggester: "sister", selected: false, count: 4, counter: "packs"),
    ShoppingItem(title: "water", suggester: "me", selected: false, count: 24, counter: "bottles")
    
]

struct ShoppingRowView: View {
    var item: ShoppingItem
    var width: CGFloat = 300
    var height: CGFloat = 70
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(item.title)
                    .font(.title)
                    .frame(width: width, height: height, alignment: .leading)
                    .padding(.horizontal, 30)
                    .foregroundColor(.white)
                    .background(Color("ssOrange"))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(color: Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)).opacity(0.3), radius: 5, x: 0, y: 10 )
            }
        }
    }
}

struct ShoppingList: View {
    var body: some View {
        VStack (alignment: .leading, spacing: 16.0) {
            
            HStack {
                HStack(alignment: .center) {
                    Text("Shopping List >")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color("ssNavy")) }
                Spacer()
            }.frame(width: 300, height: 44)
            
            
            ForEach(shoppingList) { item in
                ShoppingRowView(item: item, width: screen.width * 0.65, height: 70)
            }
        }
        .offset(x: 0)
    }
}

let screen = UIScreen.main.bounds

        
    
        
