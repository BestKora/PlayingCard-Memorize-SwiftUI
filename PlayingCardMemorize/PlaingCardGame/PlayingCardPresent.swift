//
//  PlayingCardPresent.swift
//  PlayingCardSwiftUI
//
//  Created by Tatiana Kornilova on 25/11/2020.
//  Copyright © 2020 cs193p instructor. All rights reserved.
//

import SwiftUI
import UIKit

struct PlayingCardPresent: UIViewRepresentable {
    
    var card: PlayingCard
    
    func makeUIView(context: Context) -> PlayingCardView {
         PlayingCardView()
    }
    
    func updateUIView(_ uiView: PlayingCardView, context: Context) {
        uiView.rank = card.rank.order
        uiView.suit = card.suit.rawValue
    }
}
  



struct PlayingCardPresent_Previews: PreviewProvider {
   
    static var previews: some View {
        let card = PlayingCard (suit: .spades, rank: .face("Q"))
        PlayingCardPresent(card: card)
            .aspectRatio(5.0 / 8.5, contentMode: .fit)
            .overlay(
                RoundedRectangle( cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 3)
                )
            .padding()
    }
}
