//
//  SoundManager.swift
//  Shakey Wakey
//
//  Created by Johan Karlsson on 2025-04-12.
//
import AVFoundation

class SoundManager {
    static let instance = SoundManager()
    var player: AVAudioPlayer?

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: ".mp3") else {
            print("Ljudfilen hittades inte!")
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Fel vid uppspelning av ljud: \(error.localizedDescription)")
            print(error)
        }
    }
}
