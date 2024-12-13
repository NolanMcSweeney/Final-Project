//
//  ContentView.swift
//  Final Project
//
//  Created by Nolan Brian McSweeney on 10/23/24.
//
//Citations at the bottom

import SwiftUI

struct ContentView: View {
    @State private var randomValue = 0
    @State private var rotation = 0.0
    @State private var headsCount = 0
    @State private var tailCount = 0
    @State private var isFlipping = false
    @State private var headsWinner = false
    @State private var tailsWinner = false
    @State private var winMessage = ""
    @State private var showWinFlip = false
    var body: some View {
        //For odds view
        NavigationView {
            ZStack {
                //VStack for main coin
                VStack {
                    //Title
                    CustomText(text: "Coin Flip")
                        .foregroundStyle(.white)
                        .font(.title).bold()
                        .padding()
                    HStack {
                       //Heads counter
                        CustomText(text: "Heads: \(headsCount)")
                            .font(.title).bold()
                            .foregroundColor(.white)
                            .padding()
                        
                       //Tails Counter
                        CustomText(text: "Tails: \(tailCount)")
                            .font(.title).bold()
                            .foregroundColor(.white)
                            .padding()
                        
                    }
                    //Displays Head Coin, uses random value, which all the coins are named "Coins #"
                    Image("Coins \(randomValue)")
                        .resizable()
                        .frame(width: 185, height: 200)
                        .padding(50)
                        .rotationEffect(.degrees(rotation))
                        .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 0, z: 0))
                        .onTapGesture {
                            if !isFlipping {
                                //Flips coin if times = 1
                                coinFlip(times: 1)
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    rotation += 360
                                }
                            }
                        }
                    
                    HStack {
                        
                        //Button that switches coin to silver
                        Button("Silver") {
                            
                            if !isFlipping {
                               //If the random value is not divisble, then the random value is heads
                                if randomValue % 2 == 1  {
                                    randomValue = 2
                                }
                                else {
                                   //Tails
                                    randomValue = 3
                                }
                            }
                        }
                        
                        .buttonStyle(CustomButtonStyle1())
                        
                        
                        Button("Gold") {
                            if !isFlipping {
                                if randomValue % 2 == 0 {
                                    randomValue = 1
                                }
                                else {
                                    randomValue = 0
                                }
                            }
                        }
                        
                        .buttonStyle(CustomButtonStyle2())
                        
                        Button("Bronze") {
                            if !isFlipping {
                                if randomValue % 2 == 1 {
                                    randomValue = 4
                                }
                                else {
                                    randomValue = 5
                                }
                            }
                             
                        }
                        
                        .buttonStyle(CustomButtonStyle3())
                        
                    }
                    .padding()
                    
                    HStack {
                       //Resets heads and tails count
                        Button("Reset") {
                            if !isFlipping {
                                withAnimation {
                                    headsCount = 0
                                    tailCount = 0
                                }
                            }
                            
                        }
                        .padding()
                        .buttonStyle(CustomButtonStyle4())
                        
                      //Makes new var, and while there the same, there can be a random value
                        Button("Random") {
                            if !isFlipping {
                                var newRandomValue = randomValue
                                while newRandomValue == randomValue {
                                    newRandomValue = Int.random(in: 0...5)
                                }
                                randomValue = newRandomValue
                            }
                            
                        }
                     
                        .buttonStyle(CustomButtonStyle4())
                        //Makes navigation link, that takes you to the odds pages
                        if !isFlipping {
                            NavigationLink("Odds", destination: CoinView())
                                .foregroundColor(.blue)
                                .padding()
                                .buttonStyle(CustomButtonStyle4())
                        }
                          
                        
                            
                    }
                    .padding()
                }
                
                .alert(
                    isPresented: $showWinFlip,
                    content: {
                        Alert(
                            title: Text("\(winMessage) wins!"),
                            dismissButton:
                                    .destructive(
                                        Text("Ok"),
                                        action: {
                                            withAnimation {
                                                tailsWinner = false
                                                headsWinner = false
                                                isFlipping = false
                                            }
                                        }))
                    }
                )
            }
        }
            //Creates background color
            .preferredColorScheme(.dark)
        }
    func coinFlip(times: Int) {
       //Sets isFlipping to true
        isFlipping = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            //Makes random = random int
            let random = Int.random(in: 1...100)
            if randomValue == 0 || randomValue == 1 { // Gold coin
                //Makes it 50%
                if random <= 50 {
                    headsCount += 1
                    headsWinner = true
                    winMessage = "Heads"
                    randomValue = 1
                } else {
                    tailCount += 1
                    tailsWinner = true
                    winMessage = "Tails"
                    randomValue = 0
                }
            }
            
            if randomValue == 2 || randomValue == 3 { // Silver coin
                if random <= 60 {
                    headsCount += 1
                    headsWinner = true
                    winMessage = "Heads"
                    randomValue = 2
                } else {
                    tailCount += 1
                    tailsWinner = true
                    winMessage = "Tails"
                    randomValue = 3
                }
            }
            
            if randomValue == 4 || randomValue == 5 { // Bronze coin
                if random <= 20 {
                    headsCount += 1
                    headsWinner = true
                    winMessage = "Heads"
                    randomValue = 4
                } else {
                    tailCount += 1
                    tailsWinner = true
                    winMessage = "Tails"
                    randomValue = 5
                }
            }
            
            showWinFlip = true
        }
    }

            
        
    }


#Preview {
    ContentView()
}

//Custom text font struct with custom font
struct CustomText: View {
    let text: String
    var body: some View {
        Text(text)
            .font(Font.custom("Times New Roman", size: 36))
            .font(.title).bold()
            .fontWeight(.heavy)

    }
}

//Custom struct text for the odds view page
struct CustomText1: View {
    let text: String
    var body: some View {
        Text(text)
            .font(Font.custom("Times New Roman", size: 16))
            .font(.title).bold()
            .fontWeight(.heavy)

    }
}

//Custom button struct for gray coin
struct CustomButtonStyle1: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80)
            .font(Font.custom("Times New Roman", size: 20))
            .padding()
            .background(.gray)
            .opacity(configuration.isPressed ? 0.0 : 1.0).foregroundColor(
                .white
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .font(.title).bold()
    }
}

//Custom button struct for gold coin
struct CustomButtonStyle2: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80)
            .font(Font.custom("Times New Roman", size: 20))
            .padding()
            .background(.yellow)
            .opacity(configuration.isPressed ? 0.0 : 1.0).foregroundColor(
                .white
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .font(.title).bold()
    }
}
//Custom button struct for bronze coin
struct CustomButtonStyle3: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80)
            .font(Font.custom("Times New Roman", size: 20))
            .padding()
            .background(.red)
            .opacity(configuration.isPressed ? 0.0 : 1.0).foregroundColor(
                .white
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .font(.title).bold()
    }
}

//Custom button strucut for reset, random, and odds buttons
struct CustomButtonStyle4: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 60)
            .font(Font.custom("Times New Roman", size: 15))
            .padding()
            .background(.orange)
            .opacity(configuration.isPressed ? 0.0 : 1.0).foregroundColor(
                .white
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .font(.title).bold()
    }
}
//Struct to use for the odds view page
struct CoinView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {

                VStack(alignment: .leading) {
                    CustomText(text: "The Silver Coin:")
                        .font(.title).bold()
                      
                    HStack{
                        Image("Coins 2")
                            .resizable()
                            .frame(width: 125, height: 140)
                        Image("Coins 3")
                            .resizable()
                            .frame(width: 125, height: 140)
                    }
                    CustomText1(text: "Heads: 60%  |  Tails 40%")
                        .padding()
                     
                    CustomText(text: "The Gold Coin:")
                        .font(.title).bold()
                    HStack {
                        Image("Coins 1")
                            .resizable()
                            .frame(width: 125, height: 140)
                        
                        Image("Coins 0")
                            .resizable()
                            .frame(width: 125, height: 140)
                    }
                    CustomText1(text: "Heads: 50%  |  Tails: 50%")
                        .padding()
                    CustomText(text: "The Bronze Coin:")
                    .font(.title).bold()
                    HStack {
                        Image("Coins 4")
                            .resizable()
                            .frame(width: 125, height: 140)
                        Image("Coins 5")
                            .resizable()
                            .frame(width: 125, height: 140)
                    }
                    CustomText1(text: "Heads: 20%  |  Tails: 80%")
                }
                Spacer()
            }
        }
    }
}

//Citations:

//I used the random value int, and also the randomize functions from the pig app, but I tweaked it a little bit.

//Chace and Alex helped me a lot with the finshong details.

