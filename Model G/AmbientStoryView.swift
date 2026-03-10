//
//  AmbientStoryView.swift
//  Model G
//
//  Created by Anish  Sinha on 3/10/26.
//

import SwiftUI

struct AmbientStoryView: View {
    var body: some View {
        ZStack{
            Image(systemName: "square.split.diagonal.2x2")
                .scaledToFill()
            
            VStack(spacing: 100){
                
                Text("Story Text")
                
                
                Button{
                    
                } label: {
                    
                }
                
                NavigationLink(destination: ContentView()){
                    Image(systemName: "arrowshape.turn.up.right.fill")
                        .scaleEffect(y: -1)
                }
            }
        }.frame(width: .infinity, height: .infinity)
        .navigationBarBackButtonHidden(true)
    }
}

struct AmbientStoryView_Previews: PreviewProvider {
    static var previews: some View {
        AmbientStoryView()
    }
}
