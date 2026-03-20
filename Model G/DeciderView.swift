//
//  DeciderView.swift
//  Model G
//
//  Created by Anish  Sinha on 3/10/26.
//

import SwiftUI

struct DeciderView: View {
    
    @State private var showAmbientStory: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("xLyfe")
                    .font(.custom("Rajdhani-Bold", size: 100))
                    .onTapGesture {
                        showAmbientStory = true
                    }
                    //.padding(.bottom, 100)
                    .navigationDestination(isPresented: $showAmbientStory){ AmbientStoryView(story: 0) }
                
                ProgressView(value: 0.5)
                    .foregroundColor(.cyan)
                
//                NavigationLink(destination: AmbientStoryView(story: 0)){
//                    //Text("Initiate Onboarding").padding(.vertical)
//                    Text("Begin").padding(.vertical)
//
//                }
//                NavigationLink(destination: ContentView(level: 0)){
//                    Text("Home")
//                    //Text("Go to Main Page")
//                    //Text("Shortcut to Main")
//                }
//                NavigationLink(destination: AmbientStoryView(story: 1)){
//                    //Text("Initiate Onboarding").padding(.vertical)
//                    Text("Complete").padding(.vertical)
//
//                }
            }.padding()
        }
//        .onAppear {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                        withAnimation{
//                            self.showAmbientStory = true
//                        }
//                    }
//                }
    }
}

struct DeciderView_Previews: PreviewProvider {
    static var previews: some View {
        DeciderView()
    }
}
