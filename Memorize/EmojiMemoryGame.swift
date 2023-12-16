//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Darko Krstevski on 7.9.23.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card

    //Making emojis variable GLOBAL (with keyword 'static') to make sure its initilized before the other propertiy initilizers in the class
    private static let emojis = ["💻","⌚️","📱","🖥️","⌨️","💿","🕹️","📷","⏰","🖱️",]
    
    private static func createMemoryGame() -> MemoryGame<String>{
            MemoryGame(numberOfPairOfCards: 12) { pairIndex in
                if emojis.indices.contains(pairIndex){
                   return emojis[pairIndex]
                } else {
                    return "⁉️"
                }
            }
        }
    
    
    @Published private var model = createMemoryGame()
    
    var color: Color {return .orange}
    
    var cards: Array<Card>{
        return model.cards
    }
    
    // MARK: - Intents
    func shuffle(){
        model.shuffle()
    }
    
    func choose(_ card: Card){
        model.choose(card)
    }
    
}
