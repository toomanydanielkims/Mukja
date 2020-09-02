//
//  MealPlannerView.swift
//  Mukja
//
//  Created by Daniel Kim on 8/23/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct MealPlannerView: View {
    @ObservedObject var store = MealStore()
    
    @State private var tap = false
    @State var showingSheet = false
    @State var itemAddedFeedback = false
    
    @Binding var tabSelection: Int
    
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
                        NavigationLink(destination: PickedMealsView(tabSelection: self.$tabSelection)) {
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
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle(Text("Meal Planner"))
              //  .accentColor(Color("ssBlue"))
                .navigationBarItems(
                    trailing: HStack {
                        EditButton()
                        Button(action: {
                            self.itemAddedFeedback = false
                            self.showingSheet = true }) {
                            Text("+")
                        }
                        .sheet(isPresented: $showingSheet) {
                            AddSheet(showingSheet: self.$showingSheet, itemAddedFeedback: self.$itemAddedFeedback)
                            }
                    }
                )
                .foregroundColor(Color("ssBlue"))
            }
            .buttonStyle(PlainButtonStyle())
            .navigationBarBackButtonHidden(true)
            
            if itemAddedFeedback {
                LoadingView()
                .zIndex(2)
                .animation(.easeInOut)
            }
            
        }
        
    }
}



struct MealPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        MealPlannerView(tabSelection: .constant(2))
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

class observer2 : ObservableObject{
    
    @Published var data = [pickeddata2]()
    
    init() {
        
        let db = Firestore.firestore()
        db.collection("liked").getDocuments { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents{
                
                let name = i.get("name") as! String
                let type = i.get("type") as! String
                let image = i.get("image") as! String
                
                self.data.append(pickeddata2(name: name, type: type, image: image, id: UUID().uuidString))
            }
        }
    }
}

struct pickeddata2 : Identifiable {
    
    var name : String
    var type : String
    var image : String
    var id  : String
}
