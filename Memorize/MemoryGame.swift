//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Darko Krstevski on 7.9.23.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable & Hashable {
    private(set) var cards: Array<Card>
    private(set) var score: Int
    private var seenCards: Set<Card>
    
    
    init(numberOfPairOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = []
        
        //add numberOfPairOfCards x 2 cards
        for pairIndex in 0..<max(2,numberOfPairOfCards){
            
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex)a"))
            cards.append(Card(content: content, id: "\(pairIndex)b"))
        }
        score = 0
        seenCards = []
    }
    
    mutating func choose(_  card: Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}){
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched{
                if let potentionalMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentionalMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentionalMatchIndex].isMatched = true
                        
                        score += 2
                    }
                    else{
                        if seenCards.contains(cards[chosenIndex]) {
                            score -= 1
                        }
                        seenCards.insert(cards[chosenIndex])
                        seenCards.insert(cards[potentionalMatchIndex])
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
                print(seenCards)
            }
        }
    }
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp}.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    
    
    
    
    
    
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible, Hashable{
        
        
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(content)
            hasher.combine(isMatched)
            hasher.combine(isFaceUp)
            hasher.combine(debugDescription)
        }
        
        
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
