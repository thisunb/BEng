//
//  ContentView.swift
//  PizzaApp
//
//  Created by user214202 on 5/21/22.
//

// ----------- References -------------
// http://snowfence.umn.edu/Components/winddirectionanddegrees.htm
// https://stackoverflow.com/questions/62698587/swiftui-how-to-change-text-alignment-of-label-in-toggle
// https://sarunw.com/posts/how-to-use-scrollview-in-swiftui/
//https://stackoverflow.com/questions/29670585/how-to-convert-unix-epoch-time-to-date-and-time-in-ios-swift
//https://www.advancedswift.com/local-utc-date-format-swift/https://stackoverflow.com/questions/38248941/how-to-get-time-hour-minute-second-in-swift-3-using-nsdate
//https://stackoverflow.com/questions/63239684/how-to-align-views-vertically-in-the-top-of-a-sheet-in-swiftui
// https://www.hackingwithswift.com/forums/swiftui/alert-inside-a-conditional/3480
// https://developer.apple.com/forums/thread/660481
// https://www.reddit.com/r/SwiftUI/comments/cpbgho/is_it_possible_to_control_textfield_height_or/
// https://stackoverflow.com/questions/59432776/swiftui-check-if-image-exist


import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView{
            PizzasListView()
                .tabItem{
                    Image(systemName: "list.dash")
                    Text("Pizza List")
                }
            FavouritePizzasView()
                .tabItem{
                    Image(systemName: "star.fill")
                    Text("Favourites")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
