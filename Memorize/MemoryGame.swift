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
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle()
        print("chose \(card)")
    }
    
    func index(of card: Card)-> Int{
        for index in cards.indices{
            if cards[index].id == card.id{
                return index
            }
        }
        return 0 // FIXME: bogus!
    }
    
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }

    struct Card: Equatable, Identifiable, CustomDebugStringConvertible{
  
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
        
        var id: String
        //GoodForDebugging
        var debugDescription: String{
             "\(id): \(content)"
        }
        
    }
}

