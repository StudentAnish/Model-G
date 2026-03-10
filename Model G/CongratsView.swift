//
//  CongratsView.swift
//  Model G
//
//  Created by Anish  Sinha on 3/10/26.
//

import SwiftUI

struct CongratsView: View {
    var body: some View {
        VStack (spacing: 100){
            Text("🎉").font(.system(size: 100))
            Text("Congratulations")
            Text("You've now made it to: ") + Text("Level 2").underline()
            
        }
    }
}

struct CongratsView_Previews: PreviewProvider {
    static var previews: some View {
        CongratsView()
    }
}
