//
//  ResultField.swift
//  diceR
//
//  Created by MY on 2024-01-13.
//

import Foundation
import SwiftUI

struct ResultFieldView: View {
    @Binding var path: NavigationPath
    @StateObject var vm: ViewModel
    @State private var index = 0

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.green, .white, .green], startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("\(index + 1)/\(vm.history.count)")
                    Spacer()
                    DieRollResult(die: Die.d4, vm: vm, index: $index)
                    DieRollResult(die: Die.d6, vm: vm, index: $index)
                    DieRollResult(die: Die.d8, vm: vm, index: $index)
                    DieRollResult(die: Die.d10, vm: vm, index: $index)
                    DieRollResult(die: Die.d12, vm: vm, index: $index)
                    DieRollResult(die: Die.d20, vm: vm, index: $index)
                    Spacer()
                    HStack {
                        MyButton(text: "<") { decreaseIndex() }
                        Spacer()
                        MyButton(text: "back") { path.removeLast() }
                        Spacer()
                        MyButton(text: ">") { increaseIndex() }
                    }
                }
            }
        }
    }
    
    private func decreaseIndex() {
        if index > 0 {
            index -= 1
        }
    }
    
    private func increaseIndex() {
        if index < (vm.history.count - 1) {
            index += 1
        }
    }
    
}
struct DieRollResult: View {
    let die: Die
    @StateObject var vm: ViewModel
    @Binding var index: Int

    var body: some View {
        HStack {
            Image(die.name).resizable().frame(width: 75, height: 75)
            Text(vm.printDieRolls(historyIndex: index, die: die))
        }
    }
}


// struct ResultFieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultFieldView(vm: ViewModel())
//    }
// }
