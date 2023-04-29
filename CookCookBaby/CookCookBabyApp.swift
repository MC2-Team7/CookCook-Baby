//
//  CookCookBabyApp.swift
//  CookCookBaby
//
//  Created by JaeUngJang on 2023/04/27.
//

import SwiftUI

@main
struct CookCookBabyApp: App {
    var body: some Scene {
        WindowGroup {
            //ContentView()
            ChoppingView(viewModel: ChoppingViewModel(ingredients: [.carrot,.fish,.tomato,.broccoli,.cabbage,.onion]))
        }
    }
}
