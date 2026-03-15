//
//  DeciderView.swift
//  Model G
//
//  Created by Anish  Sinha on 3/10/26.
//

import SwiftUI

struct DeciderView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Text("xLyfe")
                    .font(.custom("Rajdhani-Bold", size: 100))
                    //.padding(.bottom, 100)
                
                NavigationLink(destination: AmbientStoryView(story: 0)){
                    //Text("Initiate Onboarding").padding(.vertical)
                    Text("Onboarding").padding(.vertical)
                        
                }
                NavigationLink(destination: ContentView(level: 0)){
                    Text("Home")
                    //Text("Go to Main Page")
                    //Text("Shortcut to Main")
                }
                NavigationLink(destination: AmbientStoryView(story: 1)){
                    //Text("Initiate Onboarding").padding(.vertical)
                    Text("Complete").padding(.vertical)
                        
                }
            }.padding()
        }
    }
}

struct DeciderView_Previews: PreviewProvider {
    static var previews: some View {
        DeciderView()
    }
}
