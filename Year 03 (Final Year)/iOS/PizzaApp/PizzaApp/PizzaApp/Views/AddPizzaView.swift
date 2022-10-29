//
//  AddPizzaView.swift
//  PizzaApp
//
//  Created by user214202 on 5/21/22.
//

import SwiftUI

struct AddPizzaView: View {
    
    @State private var name = ""
    @State private var ingredients = ""
    @State private var imageName = ""
    @State private var type = ""
    
    @State private var displayAlert = false
    @State private var alertMessage = ""
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var pizzas: FetchedResults<Pizza>
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.red, .white]), startPoint: .topLeading, endPoint: .bottomLeading)
                    .edgesIgnoringSafeArea(.all)
                
                VStack (alignment: .center) {
                    ScrollView {
                        VStack {
                            TextField("Name", text: $name)
                                .disableAutocorrection(true)
                                .textFieldStyle(CustomTextFieldStyle())
                                .background(Color(red: 1, green: 0.9, blue: 0.9))
                                .cornerRadius(10)
                                .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
                            
                            ZStack{
                                
                                if ingredients.isEmpty {
                                    Text("Ingredients")
                                        .font(.system(size: 18, weight: .medium, design: .default))
                                        .padding(.leading)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.leading, 25)
                                }
                                
                                TextEditor(text: $ingredients)
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(red: 1, green: 0.9, blue: 0.9))
                                    .frame(height: 200)
                                    .opacity(ingredients.isEmpty ? 0.55 : 0.55)
                                    .cornerRadius(10)
                                    .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
                            }
                            
                            TextField("Image", text: $imageName)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .textFieldStyle(CustomTextFieldStyle())
                                .background(Color(red: 1, green: 0.9, blue: 0.9))
                                .cornerRadius(10)
                                .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
                            
                            TextField("Thumbnail", text: $imageName)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .textFieldStyle(CustomTextFieldStyle())
                                .background(Color(red: 1, green: 0.9, blue: 0.9))
                                .cornerRadius(10)
                                .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
                            
                            TextField("Type (veg / non-veg)", text: $type)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .textFieldStyle(CustomTextFieldStyle())
                                .background(Color(red: 1, green: 0.9, blue: 0.9))
                                .cornerRadius(10)
                                .padding(EdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30))
                        }
                        Spacer()
                            .navigationBarTitle("Add a Pizza", displayMode: .inline)
                    }
                    
                    HStack {
                        Button {
                            Task{
                                if(addPizza(name: name.capitalized, type: type, isFavourite: false, ingredients: ingredients, imageName: imageName, thumbName: imageName)){
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                displayAlert = true
                            }
                        } label: {
                            Text("Save Pizza")
                                .font(.system(size: 16, weight: .medium, design: .default))
                                .padding(18)
                        }
                        .alert(alertMessage, isPresented: $displayAlert) {
                            Button("OK", role: .cancel) {}
                        }
                        .background(.orange)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        
                        Button(action : { self.presentationMode.wrappedValue.dismiss()}){
                            Text("Cancel")
                                .font(.system(size: 16, weight: .medium, design: .default))
                                .padding(18)
                        }
                        .background(.red)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                    }
                    .padding(20)
                }
            }
        }
    }
    
    public struct CustomTextFieldStyle : TextFieldStyle {
        public func _body(configuration: TextField<Self._Label>) -> some View {
            configuration
                .font(.system(size: 16, weight: .medium, design: .default))
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.primary.opacity(0.3), lineWidth: 0)
                )
        }
    }
    
    func addPizza(name: String, type: String, isFavourite: Bool, ingredients: String, imageName: String, thumbName: String) -> Bool {
        
        if(name.isEmpty || type.isEmpty || ingredients.isEmpty || imageName.isEmpty || thumbName.isEmpty){
            alertMessage = "Please fill all the fields to add a pizza."
            return false
        }
        else if(type != "veg" && type != "non-veg"){
            alertMessage = "Incorrect pizza type. Enter 'veg' or 'non-veg'"
            return false
        }
        else if (UIImage(named: imageName) != nil) == false{
            alertMessage = "No image named '\(imageName)' found! Enter 'pizzaImage' to add a default image."
            return false
        }
        else{
            let pizza = Pizza(context: moc)
            pizza.name = "\(name)"
            pizza.type = "\(type)"
            pizza.isFavourite = isFavourite
            pizza.ingredients = "\(ingredients)"
            pizza.imageName = "\(imageName)"
            pizza.thumbnailName = "\(thumbName)"
            try? moc.save()
            
            alertMessage = "\(name) has been added to the list."
            return true
        }
    }
}

struct AddPizzaView_Previews: PreviewProvider {
    static var previews: some View {
        AddPizzaView()
    }
}
