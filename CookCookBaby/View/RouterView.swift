//
//  RouterView.swift
//  CookCookBaby
//
//  Created by 박승찬 on 2023/05/07.
//

import Foundation
import SwiftUI

struct RouterView : View {
    @State var showDetail = false
    @State var name: String = ""
    @State var index: Int = 1
    var body: some View {
        ZStack {
//            if showDetail {
//                ChoppingView(viewModel: ChoppingViewModel(ingredients: [.carrot,.fish,.mushroom,.scallion,.onion]),showDetail: self.$showDetail,index: $index
//                             ,ingredientName: $name)
//            } else {
//                ChooseView(viewModel: ChoppingViewModel(ingredients: [.carrot,.fish,.mushroom,.scallion,.onion]),showDetail: self.$showDetail, name: $name)
//            }
            ConnectedChoppingView(viewModel: ConnectedViewModel(ingredients: [.carrot,.fish,.mushroom,.scallion,.onion]),showDetail: self.$showDetail,index: $index, ingredientName: $name)
        }
        
    }
}
