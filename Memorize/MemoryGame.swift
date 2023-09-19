//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Darko Krstevski on 7.9.23.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    init(numberOfPairOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        
        //add numberOfPairOfCards x 2 cards
        for pairIndex in 0..<max(2,numberOfPairOfCards){
        
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card){
        
    }
    
    mutating func shuffle(){
        cards.shuffle()
        print(cards)
    }

    struct Card{
        var isFaceUp = true
        var isMatched = false
        let content: CardContent
    }
}

