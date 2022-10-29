//
//  PizzasListView.swift
//  PizzaApp
//
//  Created by user214202 on 5/21/22.
//

import SwiftUI

struct PizzasListView: View {
    
    @State private var selection = 0 // State variable for the Segmented Picker selection
    @State private var isSheetShowing = false
    @State private var pizzaType = "all"
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var pizzas: FetchedResults<Pizza>
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.red, .white, .red, .white]), startPoint: .topLeading, endPoint: .bottomLeading)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Picker("Pizzas", selection: $selection) {
                        Text("All🍕").tag(0)
                        Text("Meat🥩").tag(1)
                        Text("Veggie🥦").tag(2)
                    }
                    .pickerStyle(.segmented)
                    Spacer()
                        .navigationBarTitle("List of Pizzas", displayMode: .inline)
                    
                    VStack{
                        List(pizzas, id: \.name) { pizza in
                            if(pizza.type == pizzaType || pizzaType == "all") {
                                NavigationLink {
                                    PizzaDetailView(pizza: pizza)
                                } label: {
                                    HStack {
                                        Image(pizza.imageName ?? "pizzaImage")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .cornerRadius(10)
                                            .foregroundColor(.black)
                                        
                                        Text(pizza.name ?? "")
                                            .frame(maxWidth: .infinity, alignment: .center)
                                            .font(.system(size: 18, weight: .bold, design: .default))
                                    }
                                    .padding()
                                }
                                .background(Color(red: 1, green: 0.8, blue: 0.6))
                                .cornerRadius(10)
                            }
                        }
                        .onChange(of: selection, perform: { value in
                            if(value == 0){
                                pizzaType = "all"
                            }
                            else if(value == 1){
                                pizzaType = "non-veg"
                            }
                            else{
                                pizzaType = "veg"
                            }
                        })
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

struct PizzasListView_Previews: PreviewProvider {
    static var previews: some View {
        PizzasListView()
    }
}
