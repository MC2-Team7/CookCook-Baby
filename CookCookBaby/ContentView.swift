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
    @State var index: Int = 1
    var body: some View {
        ZStack {
            if showDetail {
                ChoppingView(viewModel: ChoppingViewModel(ingredients: [.carrot,.fish,.mushroom,.scallion,.onion]),showDetail: self.$showDetail,index: $index
                             ,ingredientName: $name)
            } else {
                ChooseView(viewModel: ChoppingViewModel(ingredients: [.carrot,.fish,.mushroom,.scallion,.onion]),showDetail: self.$showDetail, name: $name)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
