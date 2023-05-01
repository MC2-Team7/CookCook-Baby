//
//  ChoppingView.swift
//  CookCookBaby
//
//  Created by 박승찬 on 2023/04/29.
//

import SwiftUI

struct ChoppingView: View {
    @ObservedObject var viewModel : ChoppingViewModel
    @State private var draggedOffset = [CGSize.zero,CGSize.zero,CGSize.zero]
    @State private var accumulatedOffset = [CGSize.zero,CGSize.zero,CGSize.zero]
    @State private var index : Int = 0
    @State private var ingredientName = ""
    
    var soundSetting = SoundSetting()
    
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
                                    index = 1
                                    ingredientName = ingredient.imageKey
                                    SoundSetting.instance.playSound(sound: ingredient.soundKey)
                                    for i in 0...2 {
                                        draggedOffset[i] = CGSize.zero
                                        accumulatedOffset[i] = CGSize.zero
                                    }
                                    
                                }
                                
                        }
                        
                    }
                    
                }
                Spacer()
                switch index {
                case 1 :
                    Image(ingredientName)
                        //.resizable()
                        //.scaledToFit()
                        //.frame(width: geo.size.width * 2/3)
                        .offset(draggedOffset[0])
                        .gesture(drag)
                        .onTapGesture {
                            index = 2
                        }
                case 2 :
                    HStack{
                        Image(ingredientName + "Slice1.1")
                            .offset(draggedOffset[0])
                            .gesture(drag)
                            .onTapGesture {
                                index = 3
                            }
                        
                        Image(ingredientName + "Slice1")
                            .offset(draggedOffset[1])
                            .gesture(drag1)
                        
                    }
                case 3 :
                    HStack{
                        Image(ingredientName + "Slice3")
                            .offset(draggedOffset[0])
                            .gesture(drag)
                        Image(ingredientName + "Slice2")
                            .offset(draggedOffset[2])
                            .gesture(drag2)
                        Image(ingredientName + "Slice1")
                            .offset(draggedOffset[1])
                            .gesture(drag1)
                        
                    }
                    
                default:
                    Image("")
                }
                //if index {
                //    Image(ingredientName)
                //        .resizable()
                //        .scaledToFit()
                //        .frame(width: geo.size.width * 2/3)
                //        .offset(draggedOffset)
                //        .gesture(drag)
                //        .onTapGesture {
                //
                //        }
                //
                //}
                Spacer()
            }
        }
        
    }
    var drag : some Gesture {
        DragGesture()
            .onChanged{ gesture in
                
                draggedOffset[0] = accumulatedOffset[0] + gesture.translation
                
                //draggedOffset = accumulatedOffset + gesture.translation
            }
            .onEnded { gesture in
                accumulatedOffset[0] = accumulatedOffset[0] + gesture.translation
                //accumulatedOffset = accumulatedOffset + gesture.translation
            }
        
    }
    var drag1 : some Gesture {
        DragGesture()
            .onChanged{ gesture in
                
                draggedOffset[1] = accumulatedOffset[1] + gesture.translation
                
                //draggedOffset = accumulatedOffset + gesture.translation
            }
            .onEnded { gesture in
                accumulatedOffset[1]  = accumulatedOffset[1] + gesture.translation
                //accumulatedOffset = accumulatedOffset + gesture.translation
            }
    }
    var drag2 : some Gesture {
        DragGesture()
            .onChanged{ gesture in
                
                draggedOffset[2] = accumulatedOffset[2] + gesture.translation
                
                //draggedOffset = accumulatedOffset + gesture.translation
            }
            .onEnded { gesture in
                accumulatedOffset[2] = accumulatedOffset[2] + gesture.translation
                //accumulatedOffset = accumulatedOffset + gesture.translation
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
