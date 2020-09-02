//
//  SwipeView.swift
//  Mukja
//
//  Created by Daniel Kim on 8/31/20.
//  Copyright © 2020 Daniel Kim. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct SwipeView: View {
    
    @Binding var tabSelection: Int
    
    @EnvironmentObject var obs : observer
    
    var body: some View {
        ZStack {
            
            Color("ssBeige").edgesIgnoringSafeArea(.all)
            
            if obs.meal.isEmpty {
               Loader()
            }
            
            VStack{
                TopView()
                
                SwipingView()
                
                BottomView()
            }
        }
    }
}

struct TopView: View {
    var body: some View {
        HStack {
            Button(action: {
                
            }) {
                Image(systemName: "play.circle.fill").resizable().frame(width: 35, height: 35)
            }.foregroundColor(Color("ssNavy"))
            
            Spacer()
            
            Button(action: {
                
            }) {
                Image(systemName: "flame.fill").resizable().frame(width: 30, height: 35)
            }.foregroundColor(Color("ssNavy"))
            
            Spacer()
            
            Button(action: {
                
            }) {
                Image(systemName: "play.circle.fill").resizable().frame(width: 35, height: 35)
            }.foregroundColor(Color("ssNavy"))
            
        } .padding()
    }
}


struct BottomView: View {
    
    @EnvironmentObject var obs : observer
    
    var body: some View {
        
        
        HStack {
            
            Button(action: {
                
                if self.obs.last != -1{
                    self.obs.updateDB(id: self.obs.meal[self.obs.last], status: "")
                }
                
            }) { Image(systemName: "arrow.uturn.right.square").resizable().frame(width: 25, height: 25).padding()
            }.foregroundColor(Color("ssRed")).background(Color.white).shadow(radius:25).clipShape(Circle())
            
            Button(action: {
                
                if self.obs.last == -1{
                    
                    //initial meal
                    self.obs.updateDB(id: self.obs.meal[self.obs.meal.count - 1], status: "rejected")
                } else {
                    
                    //if last meal index is 5 means current meal index will be 5-1
                    self.obs.updateDB(id: self.obs.meal[self.obs.last - 1], status: "rejected")
                    
                }
                
            }) { Image(systemName: "xmark.square").resizable().frame(width: 25, height: 25).padding()
            }.foregroundColor(Color("ssRed")).background(Color.white).shadow(radius:25).clipShape(Circle())
            
            Button(action: {
                
            }) { Image(systemName: "bolt.heart.fill").resizable().frame(width: 35, height: 25).padding()
            }.foregroundColor(Color("ssRed")).background(Color.white).shadow(radius:25).clipShape(Circle())
            
            Button(action: {
                
                if self.obs.last == -1{
                                  
                                  //initial meal
                                  self.obs.updateDB(id: self.obs.meal[self.obs.meal.count - 1], status: "liked")
                              } else {
                                  
                                  //if last meal index is 5 means current meal index will be 5-1
                                  self.obs.updateDB(id: self.obs.meal[self.obs.last - 1], status: "liked")
                                  
                              }
                
            }) { Image(systemName: "heart.fill").resizable().frame(width: 25, height: 25).padding()
            }.foregroundColor(Color("ssRed")).background(Color.white).shadow(radius:25).clipShape(Circle())
            
            Button(action: {
                
            }) { Image(systemName: "bolt.heart").resizable().frame(width: 25, height: 25).padding()
            }.foregroundColor(Color("ssRed")).background(Color.white).shadow(radius:25).clipShape(Circle())
 
        }
 
    }
}

struct SwipingView: View {
    
    @EnvironmentObject var obser : observer
   
    var body: some View{
        GeometryReader{ geo in
            
            ZStack{
                
                ForEach(self.obser.meal){i in
                    
                    SwipeDetailsView(name: i.name, type: i.type, image: i.image, height: geo.size.height - 100).gesture(DragGesture()
                    
                        .onChanged({ (value) in
                            
                            if value.translation.width > 0 {
                                
                                self.obser.update(id: i, value: value.translation.width, degree: 8)
                                
                            } else {
                                
                                self.obser.update(id: i, value: value.translation.width, degree: -8)
                                
                            }
                            
                        }).onEnded({ (value) in
                            
                            if i.swipe > 0 {
                                if i.swipe > geo.size.width / 2 - 80 {
                                    //liked
                                    self.obser.update(id: i, value: 500, degree: 0)
                                    self.obser.updateDB(id: i, status: "liked")
                                    
                                } else {
                                    self.obser.update(id: i, value: 0, degree: 0)
                                }
                                
                            } else {
                                    if -i.swipe > geo.size.width / 2 - 80 {
                                    //rejected
                                    self.obser.update(id: i, value: -500, degree: 0)
                                    self.obser.updateDB(id: i, status: "rejected")
                                } else {
                                    self.obser.update(id: i, value: 0, degree: 0)
                                }
                            }
                        })
                    ).offset(x: i.swipe)
                    .rotationEffect(.init(degrees: i.degree))
                    .animation(.spring())
                }
            }
            
        }
    }
    
}

//view for individual card, plug in data into struct above
struct SwipeDetailsView: View {
    
    var name = ""
    var type = ""
    var image = ""
    var height: CGFloat = 0
    
    var body: some View {
        
        ZStack{
            
         AnimatedImage(url: URL(string: image)!).resizable().cornerRadius(20).padding(.horizontal, 15)
            
            VStack {
                
                Spacer()
                HStack {
                    VStack(alignment: .leading, content: {
                        Text(name).fontWeight(.heavy).font(.system(size:20)).foregroundColor(.white)
                        Text(type).foregroundColor(.white)
                    }) 
                    Spacer()
                }
                
            }.padding([.bottom, .leading], 35)
        }.frame(height: height)
    }
    
}
    
//just for loading animation
struct Loader: UIViewRepresentable {
       
        func makeUIView(context: UIViewRepresentableContext<Loader>) ->
            UIActivityIndicatorView {
                let indicator = UIActivityIndicatorView(style: .large)
                indicator.startAnimating()
                return indicator
        }
     
        func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loader>) {
                
            }
        }
        

//grabs firestore data
class observer: ObservableObject {
    
    @Published var meal = [datatype]()
    @Published var last = -1
    
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
                let id = i.documentID
                let status = i.get("status") as! String
                
                //here can toggle which cards are displayed
                
                //will make seen users not shown // if status == ""
                if status != "rejected" {
                    self.meal.append(datatype(id: id, name: name, image: image, type: type, swipe: 0, degree: 0))
                }
                
            }
            
        }
    }
    
//functions
    func update(id: datatype, value: CGFloat, degree: Double) {
    
    for i in 0..<self.meal.count{
    
    if self.meal[i].id == id.id {
    
        self.meal[i].swipe = value
        self.meal[i].degree = degree
        self.last = i
        }
    }
}
    
    //deprecated function
//    func goBack(index: Int){
//        self.meal[index].swipe = 0
//    }
    
    func updateDB(id: datatype, status: String) {
        let db = Firestore.firestore()
        
        db.collection("meal").document(id.id).updateData(["status": status]) { (err) in
            
            if err != nil{
                print(err)
                return
            }
            
            print("success")
            
            for i in 0..<self.meal.count {
                if self.meal[i].id == id.id{
                    if status == "liked" {
                        self.meal[i].swipe = 500
                    } else if status == "rejected" {
                        self.meal[i].swipe = -500
                    } else{
                            self.meal[i].swipe = 0
                        
                    }
                }
            }
        }
    }
    
    
}

struct datatype: Identifiable {
    
    var id: String
    var name: String
    var image: String
    var type: String
    var swipe: CGFloat
    var degree: Double
}

struct SwipeView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeView(tabSelection: .constant(5))
    }
}
