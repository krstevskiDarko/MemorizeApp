//
//  CardView.swift
//  Memorize
//
//  Created by Darko Krstevski on 16.12.23.
//

import SwiftUI


struct CardView: View{
    typealias Card = MemoryGame<String>.Card
    
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View{
        Pie(endAngle: .degrees(240))
            .padding(Constants.inset)
            .opacity(Constants.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1,contentMode: .fit)
                    .padding(Constants.inset)
            )
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        static let opacity: CGFloat = 0.4
        struct FontSize{
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest/largest
        }
        
    }
}



struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.Card
    
    static var previews: some View{
        VStack{
            HStack{
                CardView(Card(isFaceUp:true,content: "X", id: "test1"))
                    .aspectRatio(4/3,contentMode: .fit)
                CardView(Card(content: "X", id: "test1"))
            }
            HStack{
                CardView(Card(isFaceUp:true,isMatched: true,content: "This is a very long string", id: "test1"))
                CardView(Card(isMatched: true, content: "X", id: "test1"))
            }
        }
        .padding()
        .foregroundColor(.green)
        
    }
}
