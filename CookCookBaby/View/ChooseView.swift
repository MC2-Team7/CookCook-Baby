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
                        ButtonSample(imageKey: ingredient.btnImageKey, geo: geo,showDetail: $showDetail)
                    }
                }
                .padding(40)
                HStack {
                    ButtonSample(imageKey: "분홍버튼",geo: geo,showDetail: $showDetail)
                    ButtonSample(imageKey: "민트버튼",geo: geo,showDetail: $showDetail)
                    ButtonSample(imageKey: "보라버튼",geo: geo,showDetail: $showDetail)
                    ButtonSample(imageKey: "분홍버튼",geo: geo,showDetail: $showDetail)
                }
            }
        }
    }
}
    
struct ButtonSample: View {
    let imageKey: String
    let geo: GeometryProxy
    @Binding var showDetail: Bool
    var body: some View {
        Button {
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
