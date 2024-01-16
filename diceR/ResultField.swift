//
//  ResultField.swift
//  diceR
//
//  Created by MY on 2024-01-13.
//

import Foundation
import SwiftUI

struct ResultFieldView: View {
    @StateObject var vm = ViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(colors: [.green, .white, .green], startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    HStack{
                        Image("d4")
                            .resizable()
                            .frame(width: 75, height: 75)
                        Text("some text")}
                    HStack{
                        Image("d6")
                            .resizable()
                            .frame(width: 75, height: 75)
                        Text("some text") }
                    HStack{
                        Image("d8")
                            .resizable()
                            .frame(width: 75, height: 75)
                        Text("some text") }
                    HStack{
                        Image("d10")
                            .resizable()
                            .frame(width: 75, height: 75)
                        Text("some text") }
                    HStack{
                        Image("d12")
                            .resizable()
                            .frame(width: 75, height: 75)
                        Text("some text")}
                    HStack{
                        Image("d20")
                            .resizable()
                            .frame(width: 75, height: 75)
                        Text("some text")}
                    Spacer()
                    Button("Back to roll") {
                        presentationMode.wrappedValue.dismiss()
                    }.font(.largeTitle)
                   
                }
            }}
        }// ZStack
    } // body: some View

struct ResultFieldView_Previews: PreviewProvider {
    static var previews: some View {
        ResultFieldView()
    }
}
