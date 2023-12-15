//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Darko Krstevski on 7.9.23.
//

import SwiftUI



class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String>
    
    @Published var theme: Theme
    
    //Making variables GLOBAL (with keyword 'static') to make sure its initilized before the other propertiy initilizers in the class
    private static let emojis = ["💻","⌚️","📱","🖥️","⌨️","💿","🕹️","📷","⏰","🖱️",]
    
    private static var arrayOfThemes = [
        Theme(name: "Ice", emojis: ["💧","❄️","🧊","🥶","🩵","💦","⛄️","⛷️"], pairsToShow: 8, color: "blue", randomNumCards: false),
        Theme(name: "Fire", emojis: ["☄️","🔥","❤️‍🔥","🥵","🧨","🌋","🤒"], pairsToShow: 7, color: "red", randomNumCards: true),
        Theme(name: "Storm", emojis: ["🌪️","🌩️","⚡️","⛈️","🌫️","🌀","💜"], pairsToShow: 6, color: "purple", randomNumCards: true),
        Theme(name: "Earth", emojis: ["🌳","🌲","🌎","🍃","🍂","💚"], pairsToShow: 6, color: "green", randomNumCards: true),
        Theme(name: "Light", emojis: ["🔆","💡","✨","🌟","💛"], pairsToShow: 5, color: "yellow"),
        Theme(name: "Dark", emojis: ["🌚","👾","🖤","⬛️","⚔️"], pairsToShow: 6, color: "black", randomNumCards: true),
    ]
    
    init() {
        self.theme = EmojiMemoryGame.arrayOfThemes[0]

        self.model = EmojiMemoryGame.createMemoryGame(theme: EmojiMemoryGame.arrayOfThemes[0])
       
        shuffle()
    }
    
    private static func createMemoryGame(theme: Theme) -> MemoryGame<String>{

        var cardsToShow:Int
        
        if theme.randomNumCards != nil && theme.randomNumCards == true{
            cardsToShow = Int.random(in: 2...theme.pairsToShow)
        }else{
            cardsToShow = theme.pairsToShow
        }
        let arrayOFEmojis = theme.emojis.shuffled()
        
         return MemoryGame(numberOfPairOfCards: cardsToShow) { pairIndex in
                if arrayOFEmojis.indices.contains(pairIndex){
                    return arrayOFEmojis[pairIndex]
                } else {
                    return "⁉️"
                }
            }
        }
    
    var color: Color { 
        let colors = [ "blue": Color.blue,
                       "red": Color.red,
                       "green": Color.green,
                       "purple": Color.purple,
                       "yellow": Color.yellow,
                       "black": Color.black
        ]
       
        return colors[theme.color] ?? Color.accentColor
    }
    
    
    func newGame(){
        self.theme = EmojiMemoryGame.arrayOfThemes.randomElement()!
        self.model = EmojiMemoryGame.createMemoryGame(theme: theme)
        
    }
    
    var score: Int {model.score}
    
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
