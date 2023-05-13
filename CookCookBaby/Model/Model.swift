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
    let imageBar : String
    let soundKey : String
    let sliceImageKey : SliceImageKey?
    let btnImageKey : String
    init(name: String, imageBar: String, imageKey: String, soundKey: String, sliceImageKey : SliceImageKey? = nil, btnImageKey : String) {
        self.name = name
        self.imageKey = imageKey
        self.soundKey = soundKey
        self.sliceImageKey = sliceImageKey
        self.btnImageKey = btnImageKey
        self.imageBar = imageBar
    }
}
extension ingredient {
    final class SliceImageKey : Identifiable {
        let key1 : String
        let key2 : String
        let key3 : String
        let key4 : String
        init(key1: String, key2: String, key3: String, key4: String) {
            self.key1 = key1
            self.key2 = key2
            self.key3 = key3
            self.key4 = key4
        }
    }
}

extension ingredient {
    static let tomato = ingredient(
        name: "토마토",
        imageBar : "tomatoBar",
        imageKey: "tomato",
        soundKey: "tomatoSound",
        btnImageKey: ""
    )
    static let scallion = ingredient(
        name: "대파",
        imageBar : "scallionBar",
        imageKey: "scallion",
        soundKey: "scallionSound",
        btnImageKey: "greenonionButton"
    )
    static let carrot = ingredient(
        name: "당근",
        imageBar : "carrotBar",
        imageKey : "carrot3D",
        soundKey: "carrotSound",
        sliceImageKey: SliceImageKey(key1: "carrotSlice1", key2: "carrotSlice1.1", key3: "carrotSlice2", key4: "carrotSlice3"),
        btnImageKey: "carrotButton"
    )
    static let fish = ingredient(
        name: "생선",
        imageBar : "fishBar",
        imageKey: "fish",
        soundKey: "fishSound",
        btnImageKey: "fishButton"
    )
    static let mushroom = ingredient(
        name: "버섯",
        imageBar : "mushroomBar",
        imageKey: "mushroom",
        soundKey: "mushroomSound",
        btnImageKey: "mushroomButton"
    )
    static let potato = ingredient(
        name: "감자",
        imageBar : "potatoBar",
        imageKey: "potato",
        soundKey: "potatoSound",
        btnImageKey: "potatoButton"
    )
    static let eggplant = ingredient(
        name: "가지",
        imageBar : "eggplantBar",
        imageKey: "eggplant",
        soundKey: "eggplantSound",
        btnImageKey: "eggplantButton"
    )
    static let onion = ingredient(
        name: "양파",
        imageBar : "onionBar",
        imageKey: "onion",
        soundKey: "onionSound",
        btnImageKey: "onionButton"
    )
    static let paprika = ingredient(
        name: "파프리카",
        imageBar : "paprikaBar",
        imageKey: "paprika",
        soundKey: "paprikaSound",
        btnImageKey: "paprikaButton"
    )
    static let meat = ingredient(
        name: "고기",
        imageBar : "meatBar",
        imageKey: "meat",
        soundKey: "meatSound",
        btnImageKey: "meatButton"
    )
}
