//
//  PizzaDetailView.swift
//  PizzaApp
//
//  Created by user214202 on 5/21/22.
//

import SwiftUI

struct PizzaDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var pizzas: FetchedResults<Pizza>
    
    @State private var deletedPizzaName = ""
    let pizza: Pizza
    private var isFavourite: Bool
    @State private var displayAlert = false
    
    init(pizza: Pizza) {
        self.pizza = pizza
        self.isFavourite = pizza.isFavourite
    }
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.red, .white]), startPoint: .topLeading, endPoint: .bottomLeading)
                    .edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .center) {
                    ScrollView {
                        VStack {
                            Image(pizza.imageName ?? "pizzaImage")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: .infinity)
                                .cornerRadius(10)
                                .foregroundColor(.black)
                                .padding(15)
                                .background(Color(red: 1, green: 0.9, blue: 0.8))
                            
                            
                            VStack(alignment: .center, spacing: 0){
                                
                                Text("Ingredients:")
                                    .font(.system(size: 18, weight: .bold, design: .default))
                                    .italic()
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(EdgeInsets(top: 20, leading: 0, bottom: 10, trailing: 0))
                                    .background(Color(red: 1, green: 0.9, blue: 0.8))
                                    .cornerRadius(10)
                                
                                Text(pizza.ingredients ?? "None")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
                                    .background(.white)
                                    .cornerRadius(10)
                            }
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(.white)
                            .padding()
                            .cornerRadius(100)
                            
                            Button {
                                Task{
                                    handleFavourites()
                                }
                            } label: {
                                let favouriteText = pizza.isFavourite == true ? "Remove from Favourites": "Add to Favourites"
                                Text("\(favouriteText)")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                    .padding(15)
                            }
                            .background(.orange)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(.top, 20)
                            
                            Button {
                                Task{
                                    deletedPizzaName = "\(pizza.name ?? "Pizza")"
                                    moc.delete(pizza)
                                    try? moc.save()
                                    displayAlert = true
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            } label: {
                                Text("Delete Pizza")
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                    .padding(15)
                            }
                            .background(.red)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                        }
                        Spacer()
                            .navigationBarTitle(pizza.name?.capitalized ?? "Pizza", displayMode: .inline)
                    }
                    .alert(("\(deletedPizzaName) has been removed from the list."), isPresented: $displayAlert){}
                }
            }
        }
    }
    
    func handleFavourites() -> Void {
        if(pizza.isFavourite) {
            pizza.isFavourite = false
        }
        else {
            pizza.isFavourite = true
        }
        try? moc.save()
    }
    
    func deletePizza() -> Void {
        for index in 0..<pizzas.count {
            let pizza = pizzas[index]
            moc.delete(pizza)
        }
        try? moc.save()
    }
}
