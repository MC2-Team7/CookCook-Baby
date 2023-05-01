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
    let sliceImageKey : SliceImageKey?
    init(name: String, imageKey: String, soundKey: String, sliceImageKey : SliceImageKey? = nil) {
        self.name = name
        self.imageKey = imageKey
        self.soundKey = soundKey
        self.sliceImageKey = sliceImageKey
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
        imageKey: "tomato",
        soundKey: "tomatoSound"
    )
    static let carrot = ingredient(
        name: "당근",
        imageKey : "carrot3D",
        soundKey: "carrotSound",
        sliceImageKey: SliceImageKey(key1: "carrotSlice1", key2: "carrotSlice1.1", key3: "carrotSlice2", key4: "carrotSlice3")
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
        soundKey: "onionSound"
    )
}
