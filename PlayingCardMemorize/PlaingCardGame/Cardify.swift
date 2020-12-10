//
//  Cardify.swift
//  Memorize
//
//  Created by CS193P Instructor on 04/06/2020.
//  Copyright © 2020 cs193p instructor. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier  {
    private var rotation: Double
    
    init(isFaceUp: Bool){
        rotation = isFaceUp ? 0: 180
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
      }
    
    func body(content: Content) -> some View {
        ZStack {
            content.opacity(isFaceUp ? 1 : 0)
            Image("card back red").resizable().opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
        .aspectRatio(CGFloat(5.0/8.0), contentMode: .fit)
        .cornerRadius(cornerRadius)
    }
    
    // MARK: - Drawing Constants
    private let cornerRadius: CGFloat = 10.0
}

    // MARK: - Extention View
extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
