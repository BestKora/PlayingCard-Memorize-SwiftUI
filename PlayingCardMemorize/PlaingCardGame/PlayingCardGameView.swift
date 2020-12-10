//
//  PlayingCardGameView.swift
//  Memorize
//
//  Created by Tatiana Kornilova on 26/11/2020.
//  Copyright © 2020 cs193p instructor. All rights reserved.
//

import SwiftUI

struct PlayingCardGameView: View {
    @StateObject var viewModel = PlayingCardMemoryGame ()
    @State var shouldDelay = true
    
    var body: some View {
        VStack {
            GameView(viewModel: viewModel, shouldDelay: $shouldDelay)
                .onAppear { deal()}
            HStack {
                Text("Deck: \(viewModel.cardsInDeck)")
                Spacer()
                Button {
                    viewModel.resetGame()
                    shouldDelay = true
                    deal()
                } label: {Text("New Game")}
            }
            .foregroundColor(Color.white).font(.headline)
        }
            .padding()
            .background(tableColor.edgesIgnoringSafeArea(.all) )
    }
    
    // MARK: - Drawing Constants & Helper Functions
   
    private var tableColor: Color {
        Color(UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)) }
    private func deal(){
        viewModel.deal()
        DispatchQueue.main.async {
            shouldDelay = false
        }
    }
}

struct GameView: View {
    @ObservedObject  var viewModel : PlayingCardMemoryGame
    @Binding var shouldDelay: Bool
    
    var body: some View {
        GeometryReader { geometry in
            Grid (viewModel.cards) { card in
                CardPlayingView(card: card)
                    .transition(AnyTransition.asymmetric(
                                    insertion: AnyTransition.offset(flyFrom(for: geometry.size)),
                                    removal:  AnyTransition.offset(flyTo(for: geometry.size))
                                        .combined(with: AnyTransition.scale(scale: 0.5))))
                    .animation( Animation.easeInOut(duration: 1.00).delay(transitionDelay(card: card)))
                    .onTapGesture {viewModel.choose(card: card)}
                    .padding(3)
            }
        }
    }
    // MARK: - Drawing Constants & Helper Functions
   
    private func flyFrom(for size:CGSize) -> CGSize {
        CGSize(width: 0.0/*CGFloat.random(in: -size.width/2...size.width/2)*/,
               height: size.height)
    }
    private func flyTo(for size:CGSize) -> CGSize {
        CGSize(width:  CGFloat.random(in: -3*size.width...3*size.width),
               height: CGFloat.random(in: -2*size.height...(-size.height)))
    }
    private let cardTransitionDelay: Double = 0.2
    private func transitionDelay(card: MemoryGame<PlayingCard>.Card) -> Double {
        guard shouldDelay else { return 0 }
        return Double(viewModel.cards.firstIndex(matching: card)!) * cardTransitionDelay
    }
}

struct CardPlayingView: View {
    var card: MemoryGame<PlayingCard>.Card
    
    var body: some View {
            if card.isFaceUp || !card.isMatched {
                PlayingCardPresent (card: card.content)
                    .overlay(
                        RoundedRectangle( cornerRadius:  cornerRadius)
                            .stroke(card.isMatched ? .blue : Color.white.opacity(0), lineWidth: edgeLineWidth)
                        )
                    .cardify(isFaceUp: card.isFaceUp)
            }
    }
    
    // MARK: - Drawing Constants
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 5
}










struct PlayingCardGameView_Previews: PreviewProvider {
    static var previews: some View {
        PlayingCardGameView()
    }
}

