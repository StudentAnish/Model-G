//
//  DeciderView.swift
//  Model G
//
//  Created by Anish  Sinha on 3/10/26.
//

import SwiftUI

struct DeciderView: View {
    var body: some View {
        VStack{
            Text("xLyfe")
                .font(.system(size: 100))
                .padding(.bottom, 200)
            //Text("presents")
                        
            Button("Initiate Onboarding"){}.padding()
            Button("Go to Main Page"){}.padding()
        }.padding()
    }
}

struct DeciderView_Previews: PreviewProvider {
    static var previews: some View {
        DeciderView()
    }
}
