//
//  SettingsView.swift
//  Mukja
//
//  Created by Daniel Kim on 8/31/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Binding var tabSelection: Int
    
    @State var pushNotifications = true
    @State var reminderMinutes = 15
    
    
    var body: some View {
        
        ZStack {
            
            VStack {
                Image("kitchentable01")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: screen.width, height: (screen.height * 0.45))
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: -200)
            }
            
            ScrollView {
                
                HStack {
                    Toggle(isOn: $pushNotifications) {
                        Text("Recieve MealTime Alerts?")
                    }
                }
                
                
                HStack {
                    Stepper(value: $reminderMinutes, in: 0...120, step: 5) {
                        Text("Remind me \(reminderMinutes)minutes before")
                    }
                }
                
                HStack {
                    Spacer()
                    Button(action: {
                        return
                    }) { Text("Log Out")
                        .frame(width: 44, height: 44, alignment: .trailing)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tabSelection: .constant(5))
    }
}
