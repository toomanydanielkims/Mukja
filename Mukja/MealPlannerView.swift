//
//  MealPlannerView.swift
//  Mukja
//
//  Created by Daniel Kim on 8/23/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI

struct MealPlannerView: View {
    @ObservedObject var store = MealStore()
    
    @State private var tap = false
    
    func addMeal() {
        store.meals.append(Meal(title: "nothing", icon: "none", suggester: "nobody", color: "ssBlue"))
    }
    
//    init() { UITableView.appearance().allowsSelection = false
//        UITableViewCell.appearance().selectionStyle = .none }
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(store.meals) { meal in
                        NavigationLink(destination: MealDetail(meal: meal)) {
                            HStack(alignment: .center) {
                                MealPlannerRow(title: meal.title, image: meal.image, suggester: meal.suggester, color: meal.color)

                            }
                            .padding(.vertical, -20)
                            .padding(.horizontal, 30)
                        }
                        .listRowBackground(Color("ssBeige"))
                    }
                    .onDelete { index in
                        self.store.meals.remove(at: index.first!)
                    }
                    .onMove { (source: IndexSet, destination: Int) in
                        self.store.meals.move(fromOffsets: source, toOffset: destination)
                    }
                }
                .onAppear {
                    UITableView.appearance().separatorStyle = .none
                    UITableView.appearance().backgroundColor = UIColor(cgColor: #colorLiteral(red: 0.9764705882, green: 0.9607843137, blue: 0.8431372549, alpha: 1))
                    UITableViewCell.appearance().selectionStyle = .none
                }
                .navigationBarTitle(Text("Meal Planner"))
              //  .accentColor(Color("ssBlue"))
                .navigationBarItems(leading: Button(action: addMeal) {
                    Text("+")
                }, trailing: EditButton())
                .foregroundColor(Color("ssBlue"))
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}



struct MealPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        MealPlannerView()
    }
}

struct MealPlannerRow: View {
    
    @State private var tap = false
    
    var title: String
    var image: String
    var suggester: String
    var color: String
    
    var body: some View {
        VStack {
            //top portion
            HStack {
                HStack {
                    Circle()
                        .frame(width: 16.0, height: 16.0)
                        .zIndex(2)
                        .foregroundColor(Color("ssOrange"))
                    Circle()
                        .frame(width: 16.0, height: 16.0)
                        .foregroundColor(Color(.systemPink))
                        .offset(x: -15)
                        .zIndex(1)
                    Circle()
                        .frame(width: 16.0, height: 16.0)
                        .foregroundColor(Color(.systemGreen))
                        .offset(x: -30)
                        .zIndex(0)
                }
                Text("are enjoying")
                    .font(.subheadline)
                    .foregroundColor(Color("ssBrown"))
                Spacer()
                Spacer()
            }
            .padding(.top, -30)
            .padding(.horizontal, 25)
            .frame(width: 300, height: 110)
            .background(Color(.white))
            .cornerRadius(20)
            .offset(y: 50)
            
            // meal portion
            VStack(alignment: .leading) {
                    HStack {
                        Text(title)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        Text("+")
                        .foregroundColor(Color.white)
                    }
            }
            .padding(30)
            .frame(width: 300, height: 75)
            .background(Color(color))
            .cornerRadius(15)
        }
    }
}
