//
//  ContentView.swift
//  Memorize
//
//  Created by Darko Krstevski on 5.9.23.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        HStack{
            CardView(isFaceUp: true)
            CardView(isFaceUp: true)
            CardView()
            CardView()
        }
        .foregroundColor(.blue)
        .padding()
    }
}

struct CardView: View{
    @State var isFaceUp = false   //@State for animations, dont use it for the Game Logic, pointer to value of isFaceUp
    
    var body: some View{
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 12)
            if isFaceUp{
                shape.fill(.white)
                shape.strokeBorder(style:StrokeStyle(lineWidth: 5))
                Text("🥶").font(.largeTitle)
            }
            else{
                shape
            }
        }
        .onTapGesture {
            isFaceUp.toggle() //ViewModifier cannot be mutable, pointers to variables can
        }
    }
}














struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
