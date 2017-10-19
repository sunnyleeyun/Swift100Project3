//
//  ViewController.swift
//  Project3
//
//  Created by Mac on 2017/10/19.
//  Copyright © 2017年 Sunny, Lee. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

  var songPlayer = AVAudioPlayer()
  var hasBeenPaused = false
  func prepareSongAndSession(){
    do{
      // Insert the song from our Bundle to our AVAudioPlayer\
      songPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "music1", ofType: "mp3")!))
      // Prepare the song to be played
      songPlayer.prepareToPlay()
      // allow to change the rate of song
      songPlayer.enableRate = true
      // Create audio session
      let audioSession = AVAudioSession.sharedInstance()
      do {
        try audioSession.setCategory(AVAudioSessionCategoryPlayback)
      } catch let sessionError {
        print(sessionError)
      }
      
    } catch let songPlayerError{
      print(songPlayerError)
    }
  }
  
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var speed_label: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    prepareSongAndSession()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func play_Button_Tapped(_ sender: Any) {
    songPlayer.play()
  }
  
  @IBAction func pause_Button_Tapped(_ sender: Any) {
    if songPlayer.isPlaying{
      songPlayer.pause()
      hasBeenPaused = true
    }else{
      hasBeenPaused = false
    }
  }
  
  @IBAction func restart_Button_Tapped(_ sender: Any) {
    if songPlayer.isPlaying || hasBeenPaused {
      songPlayer.stop()
      songPlayer.currentTime = 0
      
      songPlayer.play()
    }else{
      songPlayer.play()
    }
  }
  
  
  @IBAction func slider_moved(_ sender: Any) {
    speed_label.text = String(format: "%.2f", slider.value)
    songPlayer.rate = slider.value
  }
  
}

