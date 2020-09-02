//
//  AddSheet.swift
//  Mukja
//
//  Created by Daniel Kim on 8/30/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//


import SwiftUI

struct AddSheet: View {
    
    @ObservedObject var eatStore = EatStore()
    
    @Binding var showingSheet: Bool
    @Binding var itemAddedFeedback: Bool
    @State private var isLoading = true
    
    @State private var today = false
    @State private var blank = ""
    
    
    //icons
    @State private var selectedIcon = 0
    struct Icon {
        var title: String
        var image: Image
    }
    let icons = ["pie", "soup", "fastfood"]
   
    //alert
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    //date
    @State private var setDate = Date()
    @State private var dropDown = false
    var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter }
    var thirtyDays: ClosedRange<Date> {
        let today = Calendar.current.date(byAdding: .minute, value: -1, to: Date())!
        let thirty = Calendar.current.date(byAdding: .day, value: 30, to: Date())!
        return today...thirty
    }
    
    var body: some View {
        NavigationView {
            Form {
                //card
                VStack(alignment: .center) {
                    //top portion
                    HStack {
                        HStack {
                            Image("\(icons[selectedIcon])")
                                .resizable()
                                .frame(width: 48.0, height: 48.0)
                                .zIndex(2)
                                .foregroundColor(Color("ssOrange"))
                        }
                        Text("\(blank) at \(setDate, formatter: dateFormatter)")
                            .font(.subheadline)
                            .foregroundColor(Color("ssNavy"))
                        Spacer()
                    }
                    .padding(.top, -30)
                    .padding(.horizontal, 25)
                    .frame(width: 300, height: 110)
                    .background(Color("ssBeige"))
                    .cornerRadius(20)
                    .offset(y: 50)
                    // meal portion
                    VStack(alignment: .leading) {
                        HStack {
                            
                            Button(action: {
                                self.addItem()
                                self.itemAddedFeedback.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    self.showingSheet = false
                                }
                            }) {
                                Text("Create")
                            }
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                            }
                        }
                    }
                    .padding(30)
                    .frame(width: 300, height: 75)
                    .background(Color("ssNavy"))
                    .cornerRadius(15)
                }.frame(maxWidth: .infinity)
                //meal name
                VStack(alignment: .leading, spacing: 40) {
                    Text("Meal Name")
                        .font(.headline)
                    VStack(alignment: .leading) {
                        TextField("Type here", text: $blank)
                    }}.padding()
                //meal icon
                VStack(alignment: .leading, spacing: 40) {
                    Text("Meal Icon")
                        .font(.headline)
                    Picker(selection: $selectedIcon, label: Text("Select")) {
                        ForEach(0 ..< icons.count) {
                            Image(self.icons[$0])
                        }}}.padding()
                //calendar
                VStack(spacing: 20) {
                    HStack {
                        Text("Today").font(.title)
                        Button(action: {
                            self.dropDown.toggle()
                        }, label: {
                            Image(systemName: "plus.square")
                        }) }.zIndex(1).padding(.top, 20)
                    
                    VStack(alignment: .center) {
                        DatePicker("Please enter a time", selection: $setDate, in: thirtyDays, displayedComponents: .date)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                            .frame(maxWidth: .infinity)
                    } .zIndex(0)
                    .opacity(dropDown ? 1 : 0)
                    .offset(y: dropDown ? 0 : -100)
                    .animation(.easeInOut)
                }
            } .navigationBarTitle("Add Meal")
        }
    .background(Color("ssBeige"))
    }
    
    func addItem() {
        if today {
            setDate = Date()
        }
        eatStore.add(item: Eat(id: UUID(), title: blank, icon: "\(icons[selectedIcon])", suggester: "mom", image: "blank", color: "blue", date: setDate))
}
    
}

struct AddSheet_Previews: PreviewProvider {
    
    static var previews: some View {
        AddSheet(showingSheet: .constant(false) , itemAddedFeedback: .constant(false))
    }
}


//struct SomeView_Previews: PreviewProvider {
//  static var previews: some View {
//    PreviewWrapper()
//  }
//
//  struct PreviewWrapper: View {
//    @State(initialValue: "") var code: String
//
//    var body: some View {
//      SomeView(code: $code)
//    }
//  }
//}
