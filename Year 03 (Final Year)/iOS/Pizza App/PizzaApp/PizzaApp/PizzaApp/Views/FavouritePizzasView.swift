//
//  FavouritePizzasView.swift
//  PizzaApp
//
//  Created by user214202 on 5/21/22.
//

import SwiftUI

struct FavouritePizzasView: View {
    
    @State private var selection = 0
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "isFavourite = %d", true)) var favouritePizzas: FetchedResults<Pizza>
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.red, .white, .red, .white]), startPoint: .topLeading, endPoint: .bottomLeading)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                        .navigationBarTitle("Favourites", displayMode: .inline)
                    
                    VStack{
                        List(favouritePizzas, id: \.name) { favouritePizza in
                            NavigationLink {
                                PizzaDetailView(pizza: favouritePizza)
                            } label: {
                                HStack {
                                    Image(favouritePizza.imageName ?? "pizzaImage")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        .foregroundColor(.black)
                                    
                                    Text(favouritePizza.name ?? "")
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .font(.system(size: 18, weight: .bold, design: .default))
                                }
                                .padding()
                            }
                            .background(Color(red: 1, green: 0.8, blue: 0.6))
                            .cornerRadius(10)
                        }
                    }
                    
                    VStack{
                        NavigationLink {
                            AddPizzaView()
                        } label: {
                            Text("+")
                                .font(.system(size: 50, weight: .medium, design: .default))
                        }
                        .frame(width: 60)
                        .background(.orange)
                        .foregroundColor(.white)
                        .cornerRadius(100)
                    }
                }
            }
        }
    }
}

struct FavouritePizzasView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritePizzasView()
    }
}
