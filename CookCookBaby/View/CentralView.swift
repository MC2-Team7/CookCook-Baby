//
//  CentralView.swift
//  CookCookBaby
//
//  Created by 김예림 on 2023/05/08.
//

import SwiftUI

struct CentralView: View {
    @StateObject var central: CentralViewModel = CentralViewModel()
    
    var body: some View {
        Text(central.message)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(20)
            .onDisappear {
                central.stopAction()
            }
    }
}

struct CentralView_Previews: PreviewProvider {
    static var previews: some View {
        CentralView()
    }
}
