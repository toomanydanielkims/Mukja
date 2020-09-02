//
//  ContentView.swift
//  Mukja
//
//  Created by Daniel Kim on 8/22/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
   // @State private var hideBar = true
    
//    @State private var isLoading = false
  //  @State private var selection: String? = nil
    @Binding var tabSelection: Int
    
    
    var body: some View {
            ZStack {
//                NavigationLink(destination: MealPlannerView( tabSelection: $tabSelection), tag: "MealPlannerView", selection: $selection) { EmptyView() }
                        
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
                            
                            Image("kitchentable01")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: screen.width, height: (screen.height * 0.45))
                                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                .edgesIgnoringSafeArea(.all)
                                .offset(y: -200)

                            MealCard()
                                .zIndex(3)
                                .offset(y: -400)
//                                .onTapGesture {
//                                    self.isLoading.toggle()
//                                    }
                            
                            HorizontalScrollView(tabSelection: $tabSelection)
                                .offset(y: -375)
                            
                            ShoppingList(tabSelection: $tabSelection)
                                .offset(y: -350)
                                .onTapGesture {
//                                    self.selection = "MealPlannerView"
//                                    self.hideBar = false
                                    self.tabSelection = 2
                            }

            //            if isLoading {
            //                LoadingView()
            //                animation(.easeInOut)
            //            }
                        }
                    }
//        .navigationBarTitle("Mukja")
//        .navigationBarHidden(hideBar)
//        .onAppear {
//                self.hideBar = true
//            }
  //  .statusBar(hidden: true)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(tabSelection: .constant(1))
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
                    .font(.system(size: 15, weight: .regular))
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
    
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {

            HStack {
                HStack(alignment: .center) {
                            Text("Upcoming Meals >")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(Color("ssNavy"))
                } .onTapGesture {
                    self.tabSelection = 2
                }
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
    
    @Binding var tabSelection: Int
    
    var body: some View {
        VStack (alignment: .leading, spacing: 16.0) {
            
            HStack {
                HStack(alignment: .center) {
                    Text("Shopping List >")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color("ssNavy"))
                }
                .onTapGesture {
                    self.tabSelection = 2
                }
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

        
    
        
