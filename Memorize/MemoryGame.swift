//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Darko Krstevski on 7.9.23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        
        //add numberOfPairOfCards x 2 cards
        for pairIndex in 0..<max(2,numberOfPairOfCards){
            
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    mutating func choose(_  card: Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched{
                if let potentionalMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentionalMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentionalMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
            
        }
    }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp}.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }

    struct Card: Equatable, Identifiable, CustomDebugStringConvertible{
  
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var id: String
        //GoodForDebugging
        var debugDescription: String{
             "\(id): \(content)"
        }
        
    }
}

extension Array {
    var only: Element? {
         count == 1 ? first : nil
    }
}
