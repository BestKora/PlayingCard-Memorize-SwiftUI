//
//  PlayingCardMemoryGame.swift
//  Memorize
//
//  Created by Tatiana Kornilova on 26/11/2020.
//  Copyright © 2020 cs193p instructor. All rights reserved.
//

import SwiftUI

class PlayingCardMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<PlayingCard> =
                          PlayingCardMemoryGame.createMemoryGame()
    
    static private var deck = PlayingCardDeck()
    
    static func createMemoryGame()-> MemoryGame<PlayingCard> {
        MemoryGame<PlayingCard> (numberOfCardsInDeck: deck.cards.count) { index in
            deck.cards[index]
        }
    }
    var numberOfCardsStart = 12
    
    // MARK: - Access to the Model
    
    var cards : Array<MemoryGame<PlayingCard>.Card> {
         model.cards
    }
    
    var cardsInDeck : Int{
        model.deck.count
    }
    
    // MARK: - Intent(s)
    
    func choose (card: MemoryGame<PlayingCard>.Card){
        model.choose(card: card)
    }
    
    func resetGame () {
        model = PlayingCardMemoryGame.createMemoryGame()
       }
    
    func deal (){
        model.deal(numberOfCardsStart)
    }
}

