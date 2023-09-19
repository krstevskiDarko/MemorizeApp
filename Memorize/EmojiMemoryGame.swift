//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Darko Krstevski on 7.9.23.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    
    //Making emojis variable GLOBAL (with keyword 'static') to make sure its initilized before the other propertiy initilizers in the class
    private static let emojis = ["💻","⌚️","📱","🖥️","⌨️","💿","🕹️","📷","⏰","🖱️",]
    
    private static func createMemoryGame() -> MemoryGame<String>{
            MemoryGame(numberOfPairOfCards: 8) { pairIndex in
                if emojis.indices.contains(pairIndex){
                   return emojis[pairIndex]
                } else {
                    return "⁉️"
                }
            }
        }
    
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card>{
        return model.cards
    }
    
    // MARK: - Intents
    func shuffle(){
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card){
        model.choose(card)
    }
    
}
