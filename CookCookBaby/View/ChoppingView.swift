//
//  ChoppingView.swift
//  CookCookBaby
//
//  Created by 박승찬 on 2023/04/29.
//

import SwiftUI

struct ChoppingView: View {
    @ObservedObject var viewModel : ChoppingViewModel
    @Binding var showDetail: Int
    @State private var draggedOffset = [CGSize.zero,CGSize.zero,CGSize.zero,CGSize.zero,CGSize.zero,CGSize.zero]
    @State private var accumulatedOffset = [CGSize.zero,CGSize.zero,CGSize.zero,CGSize.zero,CGSize.zero,CGSize.zero]
    @Binding var index : Int 
    @Binding var ingredientName: String
    @Binding var receiveIngredients: [ingredient]
    var ratio : CGFloat = 5/12
    
    // 부모 기기로 보내기 Alert용
    @State private var isShowAlert: Bool = false
    
    var soundSetting = SoundSetting()
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                HStack {
                    Button("아가야재료받아") {
                        showDetail = 2
                        index = 0
                        receiveIngredients = viewModel.receiveIngredient(ingredients: ["생선","버섯","대파"])
                    }
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
                                        for i in 0...4 {
                                            draggedOffset[i] = CGSize.zero
                                            accumulatedOffset[i] = CGSize.zero
                                        }
                                    }
                            }
                        }
                    }
                    .background(.opacity(0.15))
                    .cornerRadius(20)
      
                    Button("알림창") {
                        isShowAlert = true
                    }
                    .alert(isPresented: $isShowAlert, content: {
                        Alert(title: Text("부모한테 보낼 String :"),
                              message: Text("\(ingredientName)"))
                    })
                    .disabled(index > 4 ? false : true)
                }
                .padding(.leading)
                .frame(width: geo.size.width/5*4)
                
                Spacer()
                ZStack {
                    Image("CuttingBoard")
                        .resizable()
                        .scaledToFit()
                    
                    switch index {
                    case 1 :
                        Image(ingredientName)
                        //.resizable()
                        //.scaledToFit()
                        //.frame(width: geo.size.width * 2/3)
                            .resizable()
                            .scaledToFit()
                            .frame(height: geo.size.height*ratio)
                            .offset(draggedOffset[0])
                            .gesture(drag)
                            .onTapGesture {
                                index = 2
                                draggedOffset[1] = draggedOffset[0]
                                accumulatedOffset[1] = accumulatedOffset[0]
                                SoundSetting.instance.playSound(sound: "choppingSound")
                                let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                    impactHeavy.impactOccurred()
                                
                            }
                    case 2 :
                        HStack{
                            Image(ingredientName + "Slice1.1")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height*ratio)
                                .offset(draggedOffset[0])
                                .gesture(drag)
                                .onTapGesture {
                                    index = 3
                                    draggedOffset[2] = draggedOffset[0]
                                    accumulatedOffset[2] = accumulatedOffset[0]
                                    SoundSetting.instance.playSound(sound: "choppingSound")
                                    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                        impactHeavy.impactOccurred()
                                }
                            
                            Image(ingredientName + "Slice5")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height*ratio)
                                .offset(draggedOffset[1])
                                .gesture(drag1)
                            
                        }
                    case 3 :
                        HStack{
                            Image(ingredientName + "Slice1.2")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height*ratio)
                                .offset(draggedOffset[0])
                                .gesture(drag)
                                .onTapGesture {
                                    index = 4
                                    draggedOffset[3] = draggedOffset[0]
                                    accumulatedOffset[3] = accumulatedOffset[0]
                                    SoundSetting.instance.playSound(sound: "choppingSound")
                                    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                        impactHeavy.impactOccurred()
                                }
                            Image(ingredientName + "Slice4")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height*ratio)
                                .offset(draggedOffset[2])
                                .gesture(drag2)
                                .onTapGesture {
                                    index = 4
                                    draggedOffset[3] = draggedOffset[0]
                                    accumulatedOffset[3] = accumulatedOffset[0]
                                    SoundSetting.instance.playSound(sound: "choppingSound")
                                    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                        impactHeavy.impactOccurred()
                                }
                            Image(ingredientName + "Slice5")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height*ratio)
                                .offset(draggedOffset[1])
                                .gesture(drag1)
                            
                        }
                    case 4 :
                        HStack{
                            Image(ingredientName + "Slice1.3")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height*ratio)
                                .offset(draggedOffset[0])
                                .gesture(drag)
                                .onTapGesture {
                                    index = 5
                                    draggedOffset[4] = draggedOffset[0]
                                    accumulatedOffset[4] = accumulatedOffset[0]
                                    SoundSetting.instance.playSound(sound: "choppingSound")
                                    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                        impactHeavy.impactOccurred()
                                }
                            Image(ingredientName + "Slice3")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height*ratio)
                                .offset(draggedOffset[3])
                                .gesture(drag3)
                                .onTapGesture {
                                    index = 5
                                    draggedOffset[4] = draggedOffset[0]
                                    accumulatedOffset[4] = accumulatedOffset[0]
                                    SoundSetting.instance.playSound(sound: "choppingSound")
                                    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                        impactHeavy.impactOccurred()
                                }
                            Image(ingredientName + "Slice4")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height*ratio)
                                .offset(draggedOffset[2])
                                .gesture(drag2)
                                .onTapGesture {
                                    index = 5
                                    draggedOffset[4] = draggedOffset[0]
                                    accumulatedOffset[4] = accumulatedOffset[0]
                                    SoundSetting.instance.playSound(sound: "choppingSound")
                                    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                        impactHeavy.impactOccurred()
                                }
                            Image(ingredientName + "Slice5")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height*ratio)
                                .offset(draggedOffset[1])
                                .gesture(drag1)
                            
                        }
                    case 5 :
                        HStack{
                            Image(ingredientName + "Slice1")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height*ratio)
                                .offset(draggedOffset[0])
                                .gesture(drag)
                                .onTapGesture {
                                    index = 1
                                }
                            Image(ingredientName + "Slice2")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height*ratio)
                                .offset(draggedOffset[4])
                                .gesture(drag4)
                                .onTapGesture {
                                    index = 1
                                }
                            Image(ingredientName + "Slice3")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height*ratio)
                                .offset(draggedOffset[3])
                                .gesture(drag3)
                                .onTapGesture {
                                    index = 1
                                }
                            Image(ingredientName + "Slice4")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height*ratio)
                                .offset(draggedOffset[2])
                                .gesture(drag2)
                                .onTapGesture {
                                    index = 1
                                }
                            Image(ingredientName + "Slice5").resizable()
                                .scaledToFit()
                                .frame(height: geo.size.height*ratio)
                                .offset(draggedOffset[1])
                                .gesture(drag1)
                                .onTapGesture {
                                    index = 1
                                }
                            
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
                }//ZStack
                Spacer()
            }
            .padding(.top, 2)
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
                
                draggedOffset[1] = accumulatedOffset[1] +  gesture.translation
                
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
    var drag3 : some Gesture {
        DragGesture()
            .onChanged{ gesture in
                
                draggedOffset[3] = accumulatedOffset[3] + gesture.translation
                
                //draggedOffset = accumulatedOffset + gesture.translation
            }
            .onEnded { gesture in
                accumulatedOffset[3] = accumulatedOffset[3] + gesture.translation
                //accumulatedOffset = accumulatedOffset + gesture.translation
            }
    }
    var drag4 : some Gesture {
        DragGesture()
            .onChanged{ gesture in
                
                draggedOffset[4] = accumulatedOffset[4] + gesture.translation
                
                //draggedOffset = accumulatedOffset + gesture.translation
            }
            .onEnded { gesture in
                accumulatedOffset[4] = accumulatedOffset[4] + gesture.translation
                //accumulatedOffset = accumulatedOffset + gesture.translation
            }
    }
    
    
}
extension CGSize {
    static func + (lhs: Self, rhs: Self) -> Self {
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}
