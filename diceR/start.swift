//
//  start.swift
//  diceR
//
//  Created by MY on 2024-01-05.
//

import Foundation
import SwiftUI

struct StartView: View {
    var body: some View {
        NavigationView{
            ZStack {
                Image ("kosti")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("wellcome")
                        .padding()
                        .font(.largeTitle)
                    Text("to DiceRoller")
                        .padding()
                        .font(.title)
                    Spacer()
                    NavigationLink {ContentView().navigationBarBackButtonHidden(true)} label: {
                        Text("start")
                            .font(.largeTitle)
                    }
                }}
        
        }
    }
}

        struct StartView_Previews: PreviewProvider {
            static var previews: some View {
                StartView()
            }
        }
