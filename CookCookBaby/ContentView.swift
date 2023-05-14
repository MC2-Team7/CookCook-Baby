//
//  ContentView.swift
//  CookCookBaby
//
//  Created by JaeUngJang on 2023/04/27.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading: Bool = true
    var body: some View {
        ZStack {
            RouterView()
            if isLoading {
                launchScreenView
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {isLoading.toggle()})
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    var launchScreenView: some View {
        ZStack(alignment: .center){
            Image("LaunchScreenImage")
                .resizable()
                .scaledToFill()
        }
    }
}
