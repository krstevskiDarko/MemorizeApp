//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Darko Krstevski on 5.9.23.
//

import SwiftUI



struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack{
            HStack{
                title
                Spacer()
                Text("Score: \(viewModel.score)")
                    .font(.largeTitle)
            }
            ScrollView{
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            Button("New Game"){
                viewModel.newGame()
                viewModel.shuffle()
            }
            .font(.largeTitle)
            .foregroundColor(.black)
        }
        .foregroundColor(viewModel.color)
        .padding()
    }


    var title: some View{
        Text(viewModel.theme.name)
            .font(.largeTitle)
            .foregroundColor(viewModel.color)
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
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}















struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}
