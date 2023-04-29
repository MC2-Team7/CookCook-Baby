//
//  File.swift
//  CookCookBaby
//
//  Created by 박승찬 on 2023/04/29.
//

import Foundation

class ingredient : Identifiable {
    let name : String
    let imageKey : String
    init(name: String, imageKey: String) {
        self.name = name
        self.imageKey = imageKey
    }
}

extension ingredient {
    static let tomato = ingredient(
        name: "토마토",
        imageKey: "tomato"
    )
    static let carrot = ingredient(
        name: "당근",
        imageKey : "carrot"
    )
    static let fish = ingredient(
        name: "생선",
        imageKey: "fish"
    )
    
}
