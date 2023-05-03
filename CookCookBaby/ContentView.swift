//
//  ContentView.swift
//  CookCookBaby
//
//  Created by JaeUngJang on 2023/04/27.
//

import SwiftUI

struct ContentView: View {
    @State var showDetail = false
    @State var name: String = ""
    var body: some View {
        ZStack {
            if showDetail {
                ChoppingView(viewModel: ChoppingViewModel(ingredients: [.carrot,.fish,.tomato]),showDetail: self.$showDetail)
            } else {
                ChooseView(viewModel: ChoppingViewModel(ingredients: [.carrot,.fish,.greenOnion,.onion]),showDetail: self.$showDetail, name: $name)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
