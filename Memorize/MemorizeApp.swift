//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Darko Krstevski on 5.9.23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
