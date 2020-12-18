//
//  MemoryGame.swift
//  Memorize
//
//  Created by CS193P Instructor on 04/06/2020.
//  Copyright © 2020 cs193p instructor. All rights reserved.
//

import Foundation

struct MemoryGame <CardContent> where CardContent: Equatable {
    private (set) var cards : Array<Card>
    private (set) var deck = [Card]()     /// added
    
    // TODO: Update to take it as init parameter
    let numberOfCardsToMatch = 2
    
    private var matchedIndices: [Int] {
        cards.indices.filter { cards[$0].isFaceUp && cards[$0].isMatched } }
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {cards.indices.filter { cards[$0].isFaceUp}.only}
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card:Card) {
        if let chosenIndex = cards.firstIndex(matching: card),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                changeCards()
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }else if let chosenIndex = cards.firstIndex(matching: card),
                 cards[chosenIndex].isFaceUp,
                 !cards[chosenIndex].isMatched  { // deselect
            cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
        }
    }
    
    mutating func changeCards() {
        let replaceIndices = matchedIndices
        if matchedIndices.count == numberOfCardsToMatch
                                   && deck.count >= numberOfCardsToMatch {
            for index in replaceIndices {
                cards.remove(at: index)
                cards.insert(deck.remove(at: 0), at: index)
            }
        }
    }
    
    init (numberOfPairsOfCards: Int,cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    init (numberOfCardsInDeck: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        deck = Array<Card>()
        for i in 0..<numberOfCardsInDeck {
            let content = cardContentFactory(i)
            deck.append(Card(content: content, id: i))
        }
        deck.shuffle()
    }
    
    mutating func deal(_ numberOfCards: Int = 1) {
        for _ in 0..<numberOfCards {
            cards.append(deck.remove(at: 0))
        }
    }
    
    struct Card: Identifiable {
      var isFaceUp: Bool = false
      var isMatched: Bool = false
      var content: CardContent
      var id: Int
    }
}
