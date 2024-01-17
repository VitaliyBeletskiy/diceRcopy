//
//  ContentView.swift
//  diceR
//
//  Created by MY on 2024-01-02.
//

import SwiftUI

enum Die {
    case d4
    case d6
    case d8
    case d10
    case d12
    case d20

    var name: String {
        switch self {
        case .d4:
            return "d4"
        case .d6:
            return "d6"
        case .d8:
            return "d8"
        case .d10:
            return "d10"
        case .d12:
            return "d12"
        case .d20:
            return "d20"
        }
    }

    var faces: Int {
        switch self {
        case .d4:
            return 4
        case .d6:
            return 6
        case .d8:
            return 8
        case .d10:
            return 10
        case .d12:
            return 12
        case .d20:
            return 20
        }
    }
}

class DieRoll {
    var die: Die
    var value: Int

    init(die: Die, value: Int) {
        self.die = die
        self.value = value
    }
}

class ViewModel: ObservableObject {
    let maxNumberOfDice = 9
    let historySize = 9
    var rolls = Array<DieRoll>()
    var history = Array<Array<DieRoll>>()
    @Published var currentDie = Die.d4
    @Published var currentDieNumber = 0
    @Published var dice = [Die.d4: 0, Die.d6: 0, Die.d8: 0, Die.d10: 0, Die.d12: 0, Die.d20: 0]
    @Published var currentHistoryIndex = 1

    func onDieChosen(_ chosenDie: Die) {
        currentDie = chosenDie
        currentDieNumber = dice[chosenDie] ?? 0
    }

    func increase() {
        if currentDieNumber < maxNumberOfDice {
            currentDieNumber += 1
            dice[currentDie] = currentDieNumber
        }
    }

    func decrease() {
        if currentDieNumber > 0 {
            currentDieNumber -= 1
            dice[currentDie] = currentDieNumber
        }
    }

    func rollDice() {
        for (die, number) in dice.sorted(by: { $0.key.faces < $1.key.faces }) {
            if number < 1 { continue }
            for _ in 1 ... number {
                let rollValue = Int.random(in: 1 ... die.faces)
                rolls.append(DieRoll(die: die, value: rollValue))
            }
        }
        addRollToHistory()
        rolls.removeAll()
    }

    func addRollToHistory() {
        var new = Array<Array<DieRoll>>()
        new.append(rolls)
        new += history.dropLast(history.count == historySize ? 1 : 0)
        history = new
    }

    func printDieRolls(historyIndex: Int, die: Die) -> String {
        return history[historyIndex].filter { dieRoll in
            dieRoll.die == die
        }.map({ DieRoll in
            String(DieRoll.value)
        }).joined(separator: " ")
    }

    func canRoll() -> Bool {
        return dice.values.reduce(0, +) > 0
    }

    func canShowHistory() -> Bool {
        return history.count != 0
    }
}

struct ContentView: View {
    @State private var path = NavigationPath()
    @StateObject var vm = ViewModel()

    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .topTrailing) {
                LinearGradient(colors: [.green, .white, .green], startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                HStack {
                    MyButton(text: "history") {
                        if vm.canShowHistory() {
                            path.append("toResultField")
                        }
                    }
                }
                VStack {
                    VStack(alignment: .leading) {
                        Spacer()
                        Text("").hidden().navigationDestination(for: String.self) { view in
                            if view == "toResultField" {
                                ResultFieldView(path: $path, vm: vm).navigationBarBackButtonHidden(true)
                            }
                        }
                        HStack {
                            DieView(die: Die.d4, vm: vm)
                            Spacer()
                            DieView(die: Die.d6, vm: vm)
                        }
                        HStack {
                            DieView(die: Die.d8, vm: vm)
                            Spacer()
                            DieView(die: Die.d10, vm: vm)
                        }
                        HStack {
                            DieView(die: Die.d12, vm: vm)
                            Spacer()
                            DieView(die: Die.d20, vm: vm)
                        }
                        Spacer()
                    }.padding(EdgeInsets(top: 50, leading: 50, bottom: 50, trailing: 50))

                    HStack(alignment: .center) {
                        MyButton(text: "-") {
                            vm.decrease()
                        }
                        MyButton(text: "ROLL") {
                            if vm.canRoll() {
                                vm.rollDice()
                                path.append("toResultField")
                            }
                        }
                        MyButton(text: "+") { vm.increase() }
                    }
                }
            }
        }
    }
}

struct DieView: View {
    let die: Die
    @StateObject var vm: ViewModel

    var body: some View {
        HStack {
            Text("\(vm.dice[die] ?? 0)").font(.title)
            Image(die.name)
                .resizable()
                .frame(width: 75, height: 75)
                .if(die.name == vm.currentDie.name) {
                    $0.border(.cyan, width: 8)
                }
                .onTapGesture { vm.onDieChosen(die) }
        }
    }
}

struct MyButton: View {
    let text: String
    let myAction: () -> Void

    var body: some View {
        Button(text, action: { myAction() })
            .font(.title)
            .tracking(10)
            .foregroundColor(Color.black)
            .padding()
            .background(Color(red: 2 / 255, green: 200 / 255, blue: 242 / 255))
            .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
