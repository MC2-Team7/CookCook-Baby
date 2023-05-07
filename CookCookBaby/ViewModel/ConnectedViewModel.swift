//
//  ConnectedViewModel.swift
//  CookCookBaby
//
//  Created by 박승찬 on 2023/05/07.
//

import Foundation

class ConnectedViewModel : ObservableObject {
    @Published var ingredients : [ingredient]
    init(ingredients : [ingredient]){
        self.ingredients = ingredients
    }
    
    func transferIngredient(name: String) {
        for i in 0..<ingredients.count-1 {
            if ingredients[i].imageKey == name{
                ingredients.remove(at: i)
                break
            }
        }
    }
    
}
