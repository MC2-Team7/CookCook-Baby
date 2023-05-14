//
//  ChoppingView.swift
//  CookCookBaby
//
//  Created by 박승찬 on 2023/04/29.
//

import SwiftUI

struct ChoppingView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \RawIngredients.timestamp, ascending: true)],
        animation: .default)
    private var rawIngredients: FetchedResults<RawIngredients>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ChoppedIngredient.timestamp, ascending: true)],
        animation: .default)
    private var choppedIngredients: FetchedResults<ChoppedIngredient>

    @StateObject var central = CentralViewModel()
    @State private var text: String = ""
    @ObservedObject var viewModel : ChoppingViewModel
    @Binding var showDetail: Int
    @State private var draggedOffset = [CGSize.zero,CGSize.zero,CGSize.zero,CGSize.zero,CGSize.zero,CGSize.zero]
    @State private var accumulatedOffset = [CGSize.zero,CGSize.zero,CGSize.zero,CGSize.zero,CGSize.zero,CGSize.zero]
    @Binding var index : Int
    @Binding var ingredientName: String
    @Binding var receiveIngredients: [ingredient]
    var ratio : CGFloat = 5/12
    //슬라이스 위치 파악용
    @State private var sliceOffset: CGSize = .zero
    
    // 부모 기기로 보내기 Alert용
    @State private var isShowAlert: Bool = false
    
    @State var ringBell = false
    
    var soundSetting = SoundSetting()
    
    var body: some View {
        GeometryReader { geo in
            VStack{
                
                HStack {

                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(viewModel.ingredients){ ingredient in
                                Image(ingredient.imageBar)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width/12)
                                    .shadow(radius: 4)
                                    .onTapGesture {
                                        index = 1
                                        ingredientName = ingredient.imageKey
                                        SoundSetting.instance.playSound(sound: ingredient.soundKey)
                                        for i in 0...4 {
                                            draggedOffset[i] = CGSize.zero
                                            accumulatedOffset[i] = CGSize.zero
                                        }
                                    }
                                Spacer().frame(width: 25)
                            }

                        }
                        .padding(10)
                    }
                    .frame(width: geo.size.width/9*7)

                    Spacer()
                    
                    Divider()
                        .overlay(Color.black)
                        .frame(height: geo.size.height/10)
                    
                    
                    Spacer()
                    

                    Button{
                        if rawIngredients.count > 0 {
                            showDetail = 2
                            index = 0
                            var receive : [String] = []
                            for item in rawIngredients{
                                for ingredient in item.ingredients!.components(separatedBy: " ").map({String($0)}){
                                    receive.append(ingredient)
                                }
                                
                            }
                            receiveIngredients = viewModel.receiveIngredient(ingredients: receive)

                            deleteRawIngredients()

                        }
                    } label: {
                        if rawIngredients.count > 0 {
                            Image("lightOn")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width/15)
                                .shadow(radius: 4)
                                .rotationEffect(.degrees(ringBell ? -20 : 20), anchor: .center)
                                .animation(Animation.interpolatingSpring(mass: 0.1, stiffness: 100, damping: 50, initialVelocity: 0)
                                    .repeatForever(autoreverses: true))
                                .onAppear(){
                                    ringBell.toggle()
                                }
                        } else {
                            Image("lightOff")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width/15)
                                .shadow(radius: 6)
                                .disabled(true)
                        }
                    }
                }
                .padding(.leading, 40)
                .padding(.trailing, 70)
                .frame(width: geo.size.width)
                
                Spacer()
//                GeometryReader { limit in
                    //                let rect = CGRect(x: .size.width, y: limit.size.height,
                    //                                  width: limit.size.width, height: limit.size.height)
                    ZStack {
                        Image("CuttingBoard")
                            .resizable()
                            .scaledToFit()
                            .coordinateSpace(name: "CuttingBoard")
                        
                        
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
                    }
                    .padding(.all, 10.0)//ZStack
                    .contentShape(Rectangle())
                    .gesture(
                        //슬라이스 제스쳐 구현 부분
                        DragGesture(minimumDistance: 200)
                            .onChanged { self.sliceOffset = $0.translation}
                            .onEnded {
                                //드래그 세로의 위치가 -200보다 작은 위치로 가면 실행
                                if $0.translation.height < -200 {
                                    index += 1
                                    self.sliceOffset = .zero
                                    SoundSetting.instance.playSound(sound: "choppingSound")
                                    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                    impactHeavy.impactOccurred()
                                    if index == 6 {
                                        index = 1
                                    }
                                    switch index {
                                    case 1 :
                                        draggedOffset[0] = draggedOffset[0]
                                        accumulatedOffset[0] = accumulatedOffset[0]
                                    case 2 :
                                        draggedOffset[1] = draggedOffset[0]
                                        accumulatedOffset[1] = accumulatedOffset[0]
                                    case 3 :
                                        draggedOffset[2] = draggedOffset[0]
                                        accumulatedOffset[2] = accumulatedOffset[0]
                                    case 4 :
                                        draggedOffset[3] = draggedOffset[0]
                                        accumulatedOffset[3] = accumulatedOffset[0]
                                    case 5 :
                                        draggedOffset[4] = draggedOffset[0]
                                        accumulatedOffset[4] = accumulatedOffset[0]
                                    default :
                                        draggedOffset[0] = draggedOffset[0]
                                        accumulatedOffset[0] = accumulatedOffset[0]
                                    }
                                    //드래그 세로의 위치가 200보다 커지면 실행
                                } else if $0.translation.height > 200 {
                                    index += 1
                                    self.sliceOffset = .zero
                                    SoundSetting.instance.playSound(sound: "choppingSound")
                                    let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
                                    impactHeavy.impactOccurred()
                                    if index == 6 {
                                        index = 1
                                    }
                                    switch index {
                                    case 1 :
                                        draggedOffset[0] = draggedOffset[0]
                                        accumulatedOffset[0] = accumulatedOffset[0]
                                    case 2 :
                                        draggedOffset[1] = draggedOffset[0]
                                        accumulatedOffset[1] = accumulatedOffset[0]
                                    case 3 :
                                        draggedOffset[2] = draggedOffset[0]
                                        accumulatedOffset[2] = accumulatedOffset[0]
                                    case 4 :
                                        draggedOffset[3] = draggedOffset[0]
                                        accumulatedOffset[3] = accumulatedOffset[0]
                                    case 5 :
                                        draggedOffset[4] = draggedOffset[0]
                                        accumulatedOffset[4] = accumulatedOffset[0]
                                    default :
                                        draggedOffset[0] = draggedOffset[0]
                                        accumulatedOffset[0] = accumulatedOffset[0]
                                    }
                                    //아니면 원래 위치로 돌아감
                                } else {
                                    self.sliceOffset = .zero
                                }
                            }
                    )//gesture
//                }//geometry
                Spacer()
            }
            .padding(.top, 5)
        }
        
    }
    

    var drag : some Gesture {
        DragGesture(coordinateSpace: .named("CuttingBoard"))
            .onChanged{ gesture in
                
                draggedOffset[0] = accumulatedOffset[0] + gesture.translation
                if central.message.count > 1 {
                    showDetail = 2
                    index = 0
                }
                //draggedOffset = accumulatedOffset + gesture.translation
                
            }
            .onEnded { gesture in
                accumulatedOffset[0] = accumulatedOffset[0] + gesture.translation
                //accumulatedOffset = accumulatedOffset + gesture.translation
            }
        
    }
    var drag1 : some Gesture {
        
        DragGesture(coordinateSpace: .named("CuttingBoard"))
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
        DragGesture(coordinateSpace: .named("CuttingBoard"))
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
        DragGesture(coordinateSpace: .named("CuttingBoard"))
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
        DragGesture(coordinateSpace: .named("CuttingBoard"))
            .onChanged{ gesture in
                
                draggedOffset[4] = accumulatedOffset[4] + gesture.translation
                
                //draggedOffset = accumulatedOffset + gesture.translation
            }
            .onEnded { gesture in
                accumulatedOffset[4] = accumulatedOffset[4] + gesture.translation
                //accumulatedOffset = accumulatedOffset + gesture.translation
            }
    }
    
    private func deleteRawIngredients() {
        withAnimation {
            rawIngredients.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    

    
}
extension CGSize {
    static func + (lhs: Self, rhs: Self) -> Self {
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}
