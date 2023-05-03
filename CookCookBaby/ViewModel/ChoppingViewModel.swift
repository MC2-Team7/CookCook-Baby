//
//  ChoppingViewModel.swift
//  CookCookBaby
//
//  Created by 박승찬 on 2023/04/29.
//

import Foundation

class ChoppingViewModel : ObservableObject {
    @Published var ingredients : [ingredient]
    init(ingredients : [ingredient]){
        self.ingredients = ingredients
    }
    
}
