//
//  TutorialView.swift
//  Model G
//
//  Created by Anish  Sinha on 3/15/26.
//

import SwiftUI

struct TutorialView: View {
    
    @State private var showHomePage: Bool = false
    
    var body: some View {
        ZStack{
            VStack{
                Text("Want to know his response?")
                    .font(.custom("Rajdhani-Bold", size: 30))
                    .padding(.bottom, 50)
                
                VStack(alignment: .leading, spacing: 10){
                    HStack{
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.cyan)
                        Text("write your 3 most important goals for today")
                    }
                    HStack{
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.cyan)
                        Text("achieve them before midnight")
                    }
                    HStack{
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.cyan)
                        Text("unlock the next page")
                    }
                }
            }.padding()
            
            VStack{
                Spacer()
                
                Button{ showHomePage = true}
                label: {
                    Text("P L A Y")
                        //.font(.custom("Rajdhani-", size: 20))
                        .foregroundColor(.cyan)
                        .frame(maxWidth: .infinity)
                        .padding(20) //internal padding
                        .background(Color(.systemBackground)).cornerRadius(100)
                        .shadow(color: .cyan, radius: 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 1000)
                                .stroke(.cyan, lineWidth: 2)
                        )
                }
                .padding(.horizontal, 40)
                .padding(.vertical, 10)
                .navigationDestination(isPresented: $showHomePage){ ContentView(level: 0) }
            }
        }.navigationBarBackButtonHidden(true)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
