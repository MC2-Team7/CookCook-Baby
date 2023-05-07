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
        for i in 0..<ingredients.count {
            if ingredients[i].imageKey == name{
                ingredients.remove(at: i)
                break
            }
        }
    }
    func receiveIngredient(ingredients : [String]) {
        for ingredient in ingredients{
            switch ingredient {
            case "당근":
                self.ingredients.append(.carrot)
            case "생선":
                self.ingredients.append(.fish)
            case "버섯":
                self.ingredients.append(.mushroom)
            case "대파":
                self.ingredients.append(.scallion)
            case "양파":
                self.ingredients.append(.onion)
            default:
                print("잘못들어모 \(ingredient)")
            }
        }
    }
    
}
