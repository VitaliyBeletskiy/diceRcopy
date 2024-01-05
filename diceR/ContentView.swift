//
//  ContentView.swift
//  diceR
//
//  Created by MY on 2024-01-02.
//

import SwiftUI

struct ContentView: View {
    @State private var numberOfDice = 0
    @State  var roll: [Int] = [0,0,0,0,0,0,0,0,0,0]
    @State var dice = ["d4": 0, "d6": 0, "d8": 0, "d10": 0, "d12": 0, "d20": 0, ]
    @State private var currentDie = "d4"
    @State private var currentNumber = 0
    
    
    var body: some View {
        ZStack{
            (LinearGradient(colors: [.green, .white, .green], startPoint: .top, endPoint: .bottom))
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                VStack  (alignment: .leading) {
                    Group{
                        Image("d4")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .onTapGesture { currentDie = "d4" }
                        Image("d6")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .onTapGesture { currentDie = "d6" }
                        Image("d8")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .onTapGesture { currentDie = "d8" }
                        Image("d10")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .onTapGesture { currentDie = "d10" }
                        Image("d12")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .onTapGesture { currentDie = "d12" }
                        Image("d20")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .onTapGesture { currentDie = "d20" }
                    }
                    Spacer()
                }
                VStack (alignment: .center){
                    Spacer()
                    //Stepper ("", value: $currentNumber, in: 0...10)
                    Text("+")
                        .onTapGesture {
                            increase()
                        }
                    Text("\(currentNumber)")
                    Text("-")
                        .onTapGesture {
                            decrease()
                        }
                    Text("\(currentNumber) D\(currentDie) dice")
                        .font(.title)
                    
                    Button("ROLL", action: {
                        rollDice()
                    })
                    .font(.largeTitle)
                    .tracking(10)
                    .foregroundColor(Color.black)
                    .padding(.horizontal)
                    .background(Color.yellow)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                }
            } //HStack
        }  //ZStack
    }
    
    private func onDieChosen(newDie: String) {
        currentDie = newDie
        currentNumber = dice[newDie] ?? 0
    }
    private func increase() {
        if currentNumber<10 {
            currentNumber += 1
            dice[currentDie] = currentNumber
        }
    }
    private func decrease() {
        if currentNumber>0 {
            currentNumber -= 1
            dice[currentDie] = currentNumber
        }
    }
    private func rollDice() {
        for (dieType, dieNumber) in dice {
           // print("\(dieType) 0=> \(dieNumber)")
            
        }
        //var i = 0
        //while i<numberOfDice {
        //    roll[i] = Int.random(in: 1...4)
        //    i = i+1
        //}
        //print (roll[0...numberOfDice-1])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

