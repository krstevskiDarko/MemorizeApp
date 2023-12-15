//
//  ContentView.swift
//  Memorize
//
//  Created by Darko Krstevski on 5.9.23.
//

import SwiftUI



struct ContentView: View {
     var themeCS:[String] = ["💻","⌚️","📱","🖥️","⌨️","💿","🕹️","📷","⏰","🖱️","💻","⌚️","📱","🖥️","⌨️","💿","🕹️","📷","⏰","🖱️"]
    
     var themeFire=["❤️‍🔥","🔥","💥","☄️","🌋","🥵","❤️‍🔥","🔥","💥","☄️","🌋","🥵"]
    
     var themeIce=["💙","❄️","🌨️","🧊","🥶","☃️","💙","❄️","🌨️","🧊","🥶","☃️"]
    
    //@State var cardCount = 15
    
    @State var theme: [String] = []
        
    var body: some View {
        VStack{
            title
            ScrollView{
                cards
            }
            Spacer()
            //cardAdjusters
           themeChooser
        }
        .foregroundColor(.accentColor)
        .padding()
    }

    
    var title: some View{
        Text("Memorize!")
            .font(.largeTitle)
            .foregroundColor(.accentColor)
    }
    
    var themeChooser: some View{
        HStack(alignment: VerticalAlignment.center, content: {
            themeIceButton
            Spacer()
            themeCSButton
            Spacer()
            themeFireButton
        })
    }

    var themeIceButton: some View{
         themeButtonChooser(chooseTheme: themeIce, symbol: "snowflake", text: "Ice")
    }
    
    var themeFireButton: some View{
        themeButtonChooser(chooseTheme: themeFire, symbol: "flame.fill", text: "Fire")
    }
    var themeCSButton: some View{
        themeButtonChooser(chooseTheme: themeCS, symbol: "laptopcomputer.and.ipad", text: "Computer Science")

    }
    func themeButtonChooser(chooseTheme: [String], symbol: String, text: String) -> some View{
        Button {
            theme = chooseTheme.shuffled()
        } label: {
            VStack(alignment: HorizontalAlignment.center){
                Image(systemName: symbol)
                    .imageScale(.large)
                    .font(.largeTitle)
                Text(text)
                    .font(.caption)
            }
        }
        
    }
    
    var cards: some View{
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]){
            ForEach(0..<theme.count, id: \.self) { index in
                CardView(content: theme[index])
                    .aspectRatio(1/1.5, contentMode: .fit)
            }
        }
    }
        
    
//    var cardAdjusters:some View{
//        HStack{
//            cardRemover
//            Spacer()
//            cardAdder
//        }
//        .padding()
//        .imageScale(.large)
//        .font(.largeTitle)
//    }
//
//    func cardCountAdjuster(by offset: Int, symbol: String ) -> some View{
//        Button(action: {
//            cardCount += offset
//        }, label: {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset > themeCS.count)
//    }
//
//    var cardRemover: some View{
//        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//    }
//
//    var cardAdder: some View{
//        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
//    }
}

struct CardView: View{
    let content: String
    @State var isFaceUp = false   //@State for animations, dont use it for the Game Logic, pointer to value of isFaceUp
    
    var body: some View{
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 12)
            
            Group {
                shape.fill(.white)
                shape.strokeBorder(style:StrokeStyle(lineWidth: 5))
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            
            shape.fill().opacity(isFaceUp ? 0 : 1)
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