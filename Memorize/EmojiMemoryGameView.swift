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
        
    @State var theme: [String] = []
    
    @State var color: Color = .primary
    
    var body: some View {
        VStack{
            title
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
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
        return LazyVGrid(columns: [GridItem(.adaptive(minimum: 85),spacing: 0)],spacing: 0){
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        
    }
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
