//
//  ChooseView.swift
//  CookCookBaby
//
//  Created by 김미지 on 2023/05/02.
//

import SwiftUI

struct ChooseView: View {
    @ObservedObject var viewModel : ChoppingViewModel
    @Binding var showDetail: Int
    @Binding var name: String
    var body: some View {
        GeometryReader{ geo in
            VStack{
                HStack {
                    ForEach(0..<3,id: \.self){ num in
                        ButtonSample(imageKey: viewModel.ingredients[num].btnImageKey, geo: geo,ingredientImageKey: viewModel.ingredients[num].imageKey, showDetail: $showDetail, name: $name)
                    }
                }
                .padding(40)
                HStack {
                    ForEach(3..<6,id: \.self){ num in
                        ButtonSample(imageKey: viewModel.ingredients[num].btnImageKey, geo: geo,ingredientImageKey: viewModel.ingredients[num].imageKey, showDetail: $showDetail, name: $name)
                    }
                }
                .padding(40)
                HStack {
                    ForEach(6..<9,id: \.self){ num in
                        ButtonSample(imageKey: viewModel.ingredients[num].btnImageKey, geo: geo,ingredientImageKey: viewModel.ingredients[num].imageKey, showDetail: $showDetail, name: $name)
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
    @Binding var showDetail: Int
    @Binding var name: String
    var body: some View {
        Button {
            name = ingredientImageKey
            showDetail = 1
        } label: {
            Image(imageKey)
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width/5)
                .padding(.horizontal, 20)
        }
    }
}
