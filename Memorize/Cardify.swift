//
//  Cardify.swift
//  Memorize
//
//  Created by Darko Krstevski on 26.2.24.
//

import SwiftUI

struct Cardify: ViewModifier{
    let isFaceUp: Bool
    
    func body(content: Content) -> some View {
        
        ZStack {
            let shape = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            shape.fill(.white)
            shape.strokeBorder(style:StrokeStyle(lineWidth: Constants.lineWidth))
                .background(shape.fill(.white))
                .overlay(content)
                .opacity(isFaceUp ? 1 : 0)
            shape.fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        
    }
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
    }
}


extension View {
    func cardify(isFaceUp: Bool) -> some View{
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
