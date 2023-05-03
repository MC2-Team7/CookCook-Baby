//
//  ChooseView.swift
//  CookCookBaby
//
//  Created by 김미지 on 2023/05/02.
//

import SwiftUI

struct ChooseView: View {
    @ObservedObject var viewModel : ChoppingViewModel
    var body: some View {
        GeometryReader{ geo in
            VStack{
                HStack {
                    ForEach(viewModel.ingredients){ ingredient in
                        ButtonSample(imageKey: ingredient.btnImageKey, geo: geo)
                    }
                }
                .padding(40)
                HStack {
                    ButtonSample(imageKey: "분홍버튼",geo: geo)
                    ButtonSample(imageKey: "민트버튼",geo: geo)
                    ButtonSample(imageKey: "보라버튼",geo: geo)
                    ButtonSample(imageKey: "분홍버튼",geo: geo)
                }
            }
        }
    }
}
    
struct ButtonSample: View {
    let imageKey: String
    let geo: GeometryProxy
    var body: some View {
        Button {
        } label: {
            Image(imageKey)
                .resizable()
                .scaledToFit()
                .frame(width: geo.size.width/5)
                .padding(.horizontal, 20)
        }
    }
}

struct ChooseView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseView(viewModel: ChoppingViewModel(ingredients: [.carrot,.fish,.greenOnion,.onion]))
            .previewInterfaceOrientation(.landscapeRight)
    }
}
