//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by CS193p Instructor on 10/9/17.
//  Copyright © 2017 CS193p Instructor. All rights reserved.
//

import Foundation

struct PlayingCardDeck {
    private(set) var cards = [PlayingCard]()
    
    init() {
       
        for suit in PlayingCard.Suit.allCases {
            for rank in PlayingCard.Rank.all {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
        cards.shuffle()
    }
    
    mutating func draw() -> PlayingCard? {
        cards.count > 0
            ? cards.remove(at: Int.random(in: 0..<cards.count))
            : nil
    }
}
