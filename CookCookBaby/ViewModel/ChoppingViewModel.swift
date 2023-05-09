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
    
    func receiveIngredient(ingredients : [String]) -> [ingredient] {
        var inputIngredients: [ingredient] = []
        for ingredient in ingredients{
            switch ingredient {
            case "당근":
                inputIngredients.append(.carrot)
            case "생선":
                inputIngredients.append(.fish)
            case "버섯":
                inputIngredients.append(.mushroom)
            case "대파":
                inputIngredients.append(.scallion)
            case "양파":
                inputIngredients.append(.onion)
            case "감자":
                inputIngredients.append(.potato)
            case "고기":
                inputIngredients.append(.meat)
            case "파프리카":
                inputIngredients.append(.paprika)
            case "가지":
                inputIngredients.append(.eggplant)
            default:
                print("잘못들어옴 \(ingredient)")
            }
        }
        return inputIngredients
    }
}
