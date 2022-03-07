//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let softTime = 5
    let mediumTime = 7
    let hardTime = 12
    var player : AVAudioPlayer?
    let eggTimes = ["Soft": 5 * 60, "Medium": 7 * 60, "Hard": 12 * 60]
    var timer = Timer()
    
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        var secondsRemaining = eggTimes[hardness]!
        timer.invalidate()
        progressBar.progress = 0.0
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self](Timer) in
            if secondsRemaining > 0 {
                progressBar.progress = Float((eggTimes[hardness]! - secondsRemaining + 1)) / Float(eggTimes[hardness]!)
                secondsRemaining -= 1
            } else {
                mainTitle.text = "Time's up"
                timerAlarm()
            }
        }
        func timerAlarm() {
            do {
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "alarm_sound", ofType:"mp3")!))
                player!.play()
            } catch {
            }
        }
    }
}
