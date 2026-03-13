//
//  Model_GApp.swift
//  Model G
//
//  Created by Anish  Sinha on 3/10/26.
//

import SwiftUI

@main
struct Model_GApp: App {
    
    init() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            DeciderView()
        }
    }
}
