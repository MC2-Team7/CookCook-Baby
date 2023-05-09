//
//  SoundSetting.swift
//  CookCookBaby
//
//  Created by 박승찬 on 2023/04/29.
//

import Foundation
import SwiftUI
import AVKit

class SoundSetting : ObservableObject {
    
    static let instance = SoundSetting()
    
    var player : AVAudioPlayer?
    
    func playSound(sound: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("재생하는데 오류가 발생했습니다.        \(error.localizedDescription)")
        }
        
    }
}

