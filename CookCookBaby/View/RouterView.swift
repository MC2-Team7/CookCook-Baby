//
//  RouterView.swift
//  CookCookBaby
//
//  Created by 박승찬 on 2023/05/07.
//

import Foundation
import SwiftUI

struct RouterView : View {
    @State var receiveIngredients : [ingredient] = []
    @State var showDetail : Int = 0
    @State var name: String = ""
    @State var index: Int = 1
    var body: some View {
        ZStack {
            switch showDetail {
            case 0 :
                ChooseView(viewModel: ChoppingViewModel(ingredients: [.carrot,.fish,.mushroom,.scallion,.onion]),showDetail: self.$showDetail, name: $name)
            case 1 :
                ChoppingView(viewModel: ChoppingViewModel(ingredients: [.carrot,.fish,.mushroom,.scallion,.onion]),showDetail: self.$showDetail,index: $index ,ingredientName: $name, receiveIngredients: $receiveIngredients)
            case 2 :
                ConnectedChoppingView(viewModel: ConnectedViewModel(ingredients: receiveIngredients),showDetail: self.$showDetail,index: $index, ingredientName: $name)
            default :
                ChooseView(viewModel: ChoppingViewModel(ingredients: [.carrot,.fish,.mushroom,.scallion,.onion]),showDetail: self.$showDetail, name: $name)
            }

        }
    }
}
