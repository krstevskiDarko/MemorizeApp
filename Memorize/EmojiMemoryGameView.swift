//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Darko Krstevski on 5.9.23.
//

import SwiftUI



struct EmojiMemoryGameView: View {
     @ObservedObject var viewModel: EmojiMemoryGame
            
     let themeCS:[String] = ["💻","⌚️","📱","🖥️","⌨️","💿","🕹️","📷","⏰","🖱️","💻","⌚️","📱","🖥️","⌨️","💿","🕹️","📷","⏰","🖱️"]
    
     let themeFire=["❤️‍🔥","🔥","💥","☄️","🌋","🥵","❤️‍🔥","🔥","💥","☄️","🌋","🥵"]
    
     let themeIce=["💙","❄️","🌨️","🧊","🥶","☃️","💙","❄️","🌨️","🧊","🥶","☃️"]
    
    //@State var cardCount = 15
    
    @State var theme: [String] = []
    
    @State var color: Color = .primary
    
    var body: some View {
        VStack{
            title
            ScrollView{
                cards
            }
            Spacer()
            //cardAdjusters
            themeChooser
            Spacer()
            Button("Shuffle"){
                viewModel.shuffle()
            }
        }
        .foregroundColor(color)
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
        themeButtonChooser(chooseTheme: themeIce, symbol: "snowflake", text: "Ice", themeColor: .blue)
    }
    
    var themeFireButton: some View{
        themeButtonChooser(chooseTheme: themeFire, symbol: "flame.fill", text: "Fire",themeColor: .red )
    }
    var themeCSButton: some View{
        themeButtonChooser(chooseTheme: themeCS, symbol: "laptopcomputer.and.ipad", text: "Computer Science", themeColor: .gray)

    }
    func themeButtonChooser(chooseTheme: [String], symbol: String, text: String, themeColor: Color) -> some View{
        Button {
            theme = chooseTheme.shuffled()
            color = themeColor
        } label: {
            VStack(alignment: HorizontalAlignment.center){
                Image(systemName: symbol)
                    .imageScale(.large)
                    .font(.largeTitle)
                Text(text)
                    .font(.caption)
            }
        }
        .foregroundColor(themeColor)
        
    }
    
    var cards: some View{
////        var randNum : Int
//        if(theme.isEmpty){
//            randNum=0
//        }else{
//            randNum = Int.random(in: 2...theme.count)
//        }
        
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 85),spacing: 0)],spacing: 0){
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
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

    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View{
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 12)
            
            Group {
                shape.fill(.white)
                shape.strokeBorder(style:StrokeStyle(lineWidth: 5))
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1,contentMode: .fit)
            }
                .opacity(card.isFaceUp ? 1 : 0)
            
            shape.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
       
    }
}















struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}