//
//  ChooseView.swift
//  CookCookBaby
//
//  Created by 김미지 on 2023/05/02.
//

import SwiftUI

struct ChooseView: View {
    @ObservedObject var viewModel : ChoppingViewModel
    @Binding var showDetail: Bool
    @Binding var name: String
    var body: some View {
        GeometryReader{ geo in
            VStack{
                HStack {
                    ForEach(viewModel.ingredients){ ingredient in
                        ButtonSample(imageKey: ingredient.btnImageKey, geo: geo,ingredientImageKey: ingredient.imageKey, showDetail: $showDetail, name: $name)
                    }
                }
                .padding(40)
            }
        }
    }
}
    
struct ButtonSample: View {
    let imageKey: String
    let geo: GeometryProxy
    let ingredientImageKey: String
    @Binding var showDetail: Bool
    @Binding var name: String
    var body: some View {
        Button {
            name = ingredientImageKey
            showDetail = true
        } label: {
            Image(imageKey)
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width/5)
                .padding(.horizontal, 20)
        }
    }
}
