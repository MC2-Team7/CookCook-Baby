//
//  ChooseView.swift
//  CookCookBaby
//
//  Created by 김미지 on 2023/05/02.
//

import SwiftUI

struct ChooseView: View {
    var body: some View {
        ScrollView(.horizontal) {
                HStack {
                    ButtonSample(imageKey: "carrotButton")
                    ButtonSample(imageKey: "fishButton")
                    ButtonSample(imageKey: "대파버튼")
                    ButtonSample(imageKey: "보라버튼")
                    ButtonSample(imageKey: "민트버튼")
                }
                .padding(.vertical, 50)
                HStack {
                    ButtonSample(imageKey: "분홍버튼")
                    ButtonSample(imageKey: "민트버튼")
                    ButtonSample(imageKey: "보라버튼")
                    ButtonSample(imageKey: "분홍버튼")
                    ButtonSample(imageKey: "민트버튼")
                }
            }
        }
    }
    
    struct ButtonSample: View {
        let imageKey: String
        var body: some View {
            Button {
            } label: {
                Image(imageKey)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .padding(.horizontal, 20)
            }
        }
    }

struct ChooseView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
