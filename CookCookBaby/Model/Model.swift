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
    let soundKey : String
    init(name: String, imageKey: String, soundKey: String) {
        self.name = name
        self.imageKey = imageKey
        self.soundKey = soundKey
    }
}

extension ingredient {
    static let tomato = ingredient(
        name: "토마토",
        imageKey: "tomato",
        soundKey: "tomatoSound"
    )
    static let carrot = ingredient(
        name: "당근",
        imageKey : "carrot",
        soundKey: "carrotSound"
    )
    static let fish = ingredient(
        name: "생선",
        imageKey: "fish",
        soundKey: "fishSound"
    )
    static let broccoli = ingredient(
        name: "브로콜리",
        imageKey: "broccoli",
        soundKey: "broccoliSound"
    )
    static let cabbage = ingredient(
        name: "양배추",
        imageKey: "cabbage",
        soundKey: "cabbageSound"
    )
    static let onion = ingredient(
        name: "양파",
        imageKey: "onion",
        soundKey: "nionSound"
    )
}
