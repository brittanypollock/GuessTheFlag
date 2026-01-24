//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Brittany Pollock on 1/18/26.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var gameOver = false
    @State private var scoreTitle = ""
    
    @State private var turns = 1
    @State private var scorePoint = 0
    @State private var scoreBody = ""
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
                ], center: .top, startRadius: 200, endRadius: 700)                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                            .shadow(radius: 10)
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scorePoint)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Text("Turn: \(turns)/8")
                    .foregroundStyle(.white)
                    .font(.headline.bold())
                
                Spacer()
                
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreBody)
        }
        
        .alert(scoreTitle, isPresented: $gameOver) {
            Button("Reset", action: reset)
                .buttonStyle(.borderedProminent)
        } message: {
            Text(scoreBody)
        }
    }
    
    func reset() {
        turns = 1
        scorePoint = 0
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            scorePoint += 1
            scoreBody = "Your score is \(scorePoint)"
        } else {
            scoreTitle = "Incorrect"
            scoreBody = "That's \(countries[number])'s flag."
        }
        
        turns += 1
        
        if turns == 8 {
            scoreTitle = "Game Over"
            scoreBody = "Your score was \(scorePoint)."
            gameOver = true
            return
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
