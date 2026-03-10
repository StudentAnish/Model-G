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
            
            Text("Level: 3").font(.largeTitle)
            
            Top3MissionRowView(number: 1)
            Top3MissionRowView(number: 2)
            Top3MissionRowView(number: 3)
            
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}

struct Top3MissionRowView: View {
    
    @State var missionName: String = ""
    var number: Int
    
    var body: some View{
        HStack{
            Image(systemName: "\(number).circle")
                .font(.system(size: 20))
            TextField("enter your mission", text: $missionName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
