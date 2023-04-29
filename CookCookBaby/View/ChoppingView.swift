//
//  ChoppingView.swift
//  CookCookBaby
//
//  Created by 박승찬 on 2023/04/29.
//

import SwiftUI

struct ChoppingView: View {
    @ObservedObject var viewModel : ChoppingViewModel
    @State private var draggedOffset = CGSize.zero
    @State private var accumulatedOffset = CGSize.zero
    @State private var index = false
    @State private var ingredientName = ""
    var body: some View {
        GeometryReader { geo in
            VStack{
                ScrollView(.horizontal) {
                    HStack{
                        ForEach(viewModel.ingredients){ ingredient in
                            Image(ingredient.imageKey)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width/10)
                                .onTapGesture {
                                    index = true
                                    ingredientName = ingredient.imageKey
                                    
                                }
                                
                        }
                        
                    }
                    
                }
                Spacer()
                if index {
                    Image(ingredientName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 2/3)
                        .offset(draggedOffset)
                        .gesture(drag)
                        
                }
                Spacer()
            }
        }
        
    }
    var drag : some Gesture {
        DragGesture()
            .onChanged{ gesture in
                draggedOffset = accumulatedOffset + gesture.translation
            }
            .onEnded { gesture in
                accumulatedOffset = accumulatedOffset + gesture.translation
            }
        
    }
}
extension CGSize {
    static func + (lhs: Self, rhs: Self) -> Self {
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}

struct ChoppingView_Previews: PreviewProvider {
    static var previews: some View {
        ChoppingView(viewModel: ChoppingViewModel(ingredients: [.carrot,.fish,.tomato]))
    }
}
