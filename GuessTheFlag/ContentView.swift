//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Navati Jain on 2020-08-04.
//

import SwiftUI



struct ContentView: View {
    @State private var showingAlert = false
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    
    @State private var scoreTitle = ""
    @State private var score = 0
    
    var body: some View {
        
        ZStack {
            //Color.blue.edgesIgnoringSafeArea(.all)
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            Spacer()
            VStack(spacing: 30){
                VStack {
                    Text("Tap the flag of").foregroundColor(.white)
                    Text(countries[correctAnswer]).font(.largeTitle).fontWeight(.black)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black,lineWidth: 1))
                            .shadow(color:.black, radius: 2)
                    }
                }
                Text("Current Score: \(score)").foregroundColor(.white)
            }
            
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
        })
    }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score = score + 1
        } else {
            scoreTitle = "Wrong! That is the flag of \(countries[number])"
        }
        showingScore = true
    }
      
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
