//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Bugra Aslan on 12.02.2024.
//

/*
 TODO: with the additions I marked as TODO will make this game something
 However I don't see value to continue this one as of right now because
 it will just be copy paste and change few text...
 */

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 7
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    /*** Background Colors  */
    let darkBlue = Color(red: 0.1, green: 0.2, blue: 0.45)
    let darkRed = Color(red: 0.76, green: 0.15, blue: 0.26)
    
    var body: some View {
        ZStack {
            // Background Color
//            LinearGradient(colors: [.cyan, .green], startPoint: .top, endPoint: .bottom)
//                .ignoresSafeArea()
            RadialGradient(stops: [
                .init(color: darkBlue, location: 0.3),
                .init(color: darkRed, location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            Color(white: 0.2, opacity: 0.3)
//                .background(.ultraThinMaterial)
                .ignoresSafeArea()
            // Game Part
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .padding(.bottom)
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                    .padding(.bottom, 40)
                Spacer()
                Spacer()
                VStack(spacing: 30/2) {
                    // Title Texts
                    VStack {
                        Text("Tap the flag of")
                            .font(.title2)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    .foregroundStyle(.white)
                    
                    // Buttons
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.rect(cornerRadius: 10.0))
    //                            .shadow(radius: 7, y: 7.0)
                                .shadow(color: .black, radius: 7, y: 7.0)
                                .shadow(color: .white, radius: 3, y: -3.0)
                        }
                    }
                    .padding()
    //                .background(.ultraThinMaterial)
    //                .background(.gray)
                }
                /* This is what tutorial made me do it, hence I did it. However
                 I really didn't like this */
                .frame(maxWidth: .infinity)
                /*
                // Using screen width with -20 horizontal padding looks better
                // However UIScreen.main will be deprecated so I need to find the
                // proper way to do this
//                .frame(maxWidth: UIScreen.main.bounds.size.width)
//                .padding(.horizontal, w-20)
                 */
                .padding(.vertical, 20)
                .background(.ultraThinMaterial) // changed from .regularMaterial
                .clipShape(.rect(cornerRadius: 20))
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if score < 8 {
                Button("Continue", action: askQuestion)
            } else {
                Button("Restart", action: {
                    askQuestion()
                    score = 0
                })
            }
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            if score < 7 {
                scoreTitle = "Correct"
            } else {
                scoreTitle = "You WIN!!! Do you want to restart?"
            }
        } else {
            /* TODO: for more gamification
             beginner difficulty: same as now
             easy difficulty: when answer is wrong add score -= 1 or
             medium difficulty: when add 3 lives and take 1 live every wrong answer.
                -- same logic as keeping the score
             hard difficulty: when answer is wrong take 1 live and set score to 0.
                -- force players to get 8 consecutive right answers.
                -- It should be hard after all.
             In order to achieve this:
                add a MainMenuView
                create different views for each difficulty, with background colors getting darker for each diffuculty
                extract the Game part from here
                    to use the same graphic style everywhere
                create different alert system for each difficulty.
             */
            scoreTitle = "Wrong! That is the flag of \(countries[number])"
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


//        ZStack {
//            VStack(spacing: 0) {
//                Color.red
//                Color.green
//            }
//            .ignoresSafeArea()
//            HStack(spacing: 20) {
//                VStack(spacing: 20) {
//                    Text("1")
//                    Text("4")
//                    Text("7")
//                }
//                VStack(spacing: 20) {
//                    Text("2")
//                    Text("5")
//                    Text("8")
//                }
//                VStack(spacing: 20) {
//                    Text("3")
//                    Text("6")
//                    Text("9")
//                }
//            }
//            .foregroundStyle(.secondary)
//            .frame(width: 500, height: 1000)
//            .background(.ultraThinMaterial)
//            ZStack {
////                LinearGradient(colors: [.white, .blue], startPoint: .top, endPoint: .bottom)
//                //            LinearGradient(stops: [
//                //                Gradient.Stop(color: .white, location: 0.45),
//                //                Gradient.Stop(color: .blue, location: 0.55)
//                //            ], startPoint: .top, endPoint: .bottom)
////                RadialGradient(colors: [.black, .blue], center: .bottom, startRadius: 30, endRadius: 1000)
////                AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
//            }
//        }



//        VStack {
//            Spacer()
//            Button("Button 1") { }
//                .buttonStyle(.bordered)
//            Button("Button 2", role: .destructive) { }
//                .buttonStyle(.bordered)
//            Button("Button 3") { }
//                .buttonStyle(.borderedProminent)
//                .tint(.mint)
//            Button("Button 4", role: .destructive) { }
//                .buttonStyle(.borderedProminent)
//            Spacer()
//            Spacer()
//            Button() {
//
//            } label: {
//                Label("Edit", systemImage: "pencil")
//                    .padding()
//            }
//            .buttonStyle(.bordered)
//            Spacer()
//        }


//@State private var showingAlert = false
//
//    var body: some View {
////        VStack {
////            Button("Show Alert") {
////                showingAlert = true
////            }
////            .alert("Very important message", isPresented: $showingAlert) {
////                Button("OK", role: .cancel) {}
////            } message: {
////                Text("Readable Stufff!!!!11!!!")
////            }
////        }
//    }
