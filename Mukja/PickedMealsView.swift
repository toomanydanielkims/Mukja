//
//  PickedMealsView.swift
//  Mukja
//
//  Created by Daniel Kim on 9/1/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct PickedMealsView: View {
    @Binding var tabSelection: Int
    
    @ObservedObject var datas = observer1()
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(datas.data.sorted()) { i in
                    NavigationLink(destination: MealDetail(meal: i)) {
                        cards(name: i.name, image: i.image)
//                        .padding(.vertical, 8)
                    }
                }
//                .onDelete { index in
//                    self.store.updates.remove(at: index.first!)
//                }
//                .onMove { (source: IndexSet, destination: Int) in
//                    self.store.updates.move(fromOffsets: source, toOffset: destination)
//                }
            }
            .navigationBarTitle(Text("Picked Meal"))
            .navigationBarItems(trailing: EditButton())
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    
    }


//HStack {
//    Image(update.image)
//        .resizable()
//        .aspectRatio(contentMode: .fit)
//        .frame(width: 80, height: 80)
//        .background(Color.black)
//        .cornerRadius(20)
//        .padding(.trailing, 4)
//
//    VStack(alignment: .leading, spacing: 8.0) {
//        Text(update.title)
//            .font(.system(size: 20, weight: .bold))
//
//        Text(update.text)
//            .lineLimit(2)
//            .font(.subheadline)
//            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
//
//        Text(update.date)
//            .font(.caption)
//            .fontWeight(.bold)
//            .foregroundColor(.secondary)
//    }
//}


//if datas.data.isEmpty{
//
//               Text("No Meals Picked")
//           }


struct cards : View {
    
    var name = ""
    var image = ""
    var body : some View{
        
        HStack{
            
            AnimatedImage(url: URL(string: image)!).resizable().frame(width: 65, height: 65).clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            
            Text(name).fontWeight(.heavy)
        }
    }
}

class observer1 : ObservableObject{
    
    @Published var data = [pickeddata1]()
    
    init() {
        
        let db = Firestore.firestore()
        db.collection("meal").getDocuments { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents{
                
                let name = i.get("name") as! String
                let type = i.get("type") as! String
                let image = i.get("image") as! String
                let status = i.get("status") as! String
                let rank = i.get("rank") as! Int
                
                
                if status == "liked" {
                
                    self.data.append(pickeddata1(name: name, type: type, image: image, rank: rank, id: UUID().uuidString))
                }
            }
        }
    }
}

struct pickeddata1 : Identifiable, Comparable {
    
    static func < (lhs: pickeddata1, rhs: pickeddata1) -> Bool {
        return lhs.rank > rhs.rank
    }
    
    
    var name : String
    var type : String
    var image : String
    var rank: Int
    var id  : String
}
