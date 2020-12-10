//
//  PlayingCardPresent.swift
//  PlayingCardMemorize
//
//  Created by Tatiana Kornilova on 02/12/2020.
//

import SwiftUI
import UIKit

struct PlayingCardPresent: UIViewRepresentable {
    
    var card: PlayingCard
    
    func makeUIView(context: Context) -> PlayingCardView {
        let  playingCardView = PlayingCardView()
        
        playingCardView.rank = card.rank.order
        playingCardView.suit = card.suit.rawValue
        
        return playingCardView
    }
    
    func updateUIView(_ uiView: PlayingCardView, context: Context) {
        
    }
}

struct PlayingCardPresent_Previews: PreviewProvider {
    
    static var previews: some View {
        PlayingCardPresent(card: PlayingCard (suit: .spades, rank: .face("Q")))
    }
}
