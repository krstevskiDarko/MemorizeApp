//
//  ContentView.swift
//  Memorize
//
//  Created by Darko Krstevski on 5.9.23.
//

import SwiftUI



struct ContentView: View {
    let emojis:[String] = ["💻","⌚️","📱","🖥️","⌨️","💿"]
    
    var body: some View {
        HStack{
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.blue)
        .padding()
    }
}

struct CardView: View{
    let content: String
    @State var isFaceUp = false   //@State for animations, dont use it for the Game Logic, pointer to value of isFaceUp
    
    var body: some View{
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 12)
            if isFaceUp{
                shape.fill(.white)
                shape.strokeBorder(style:StrokeStyle(lineWidth: 5))
                Text(content).font(.largeTitle)
            }
            else{
                shape
            }
        }
        .onTapGesture {
            isFaceUp.toggle() //ViewModifier cannot be mutable, the body of View can
        }
    }
}














struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
