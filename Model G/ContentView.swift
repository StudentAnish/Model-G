//
//  ContentView.swift
//  Model G
//
//  Created by Anish  Sinha on 3/10/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 100){
            Text("🐙").font(.system(size: 200))
                .shadow(color: .primary, radius: 10)
            
            Text("Enter your top 3").font(.largeTitle)
            
            Text("1. __________________________")
            Text("2. __________________________")
            Text("3. __________________________")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
