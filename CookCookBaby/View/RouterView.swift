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
    @State var showDetail : Int = 1
    @State var name: String = ""
    @State var index: Int = 1
    
    let persistenceController = PersistenceController.shared

    var body: some View {
        ZStack {
            switch showDetail {
            case 0 :
                ChooseView(viewModel: ChoppingViewModel(ingredients: [.carrot,.fish,.mushroom,.scallion,.onion,.eggplant,.meat,.paprika,.potato]),showDetail: self.$showDetail, name: $name)
            case 1 :
                ChoppingView(viewModel: ChoppingViewModel(ingredients: [.carrot,.fish,.mushroom,.scallion,.onion,.eggplant,.meat,.paprika,.potato]),showDetail: self.$showDetail,index: $index ,ingredientName: $name, receiveIngredients: $receiveIngredients)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            case 2 :
                ConnectedChoppingView(viewModel: ConnectedViewModel(ingredients: receiveIngredients),showDetail: self.$showDetail,index: $index, ingredientName: $name)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)

            default :
                ChooseView(viewModel: ChoppingViewModel(ingredients: [.carrot,.fish,.mushroom,.scallion,.onion,.eggplant,.meat,.paprika,.potato]),showDetail: self.$showDetail, name: $name)
            }

        }
    }
}
