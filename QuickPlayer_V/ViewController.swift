//
//  ViewController.swift
//  QuickPlayer_V
//
//  Created by Chung on 8/23/16.
//  Copyright © 2016 newayplus. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audio = AVAudioPlayer()
    var isPlaying = true
    
    
    
    @IBOutlet weak var slide: UISlider!
    @IBOutlet weak var btnPlay: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        audio = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music", ofType: ".mp3")!))
        audio.prepareToPlay()
        addThumbImgForSlider()
    
    }
    
    
    @IBAction func btnPlay(sender: UIButton) {
        if isPlaying {
            audio.play()
            btnPlay.setImage(UIImage(named: "pause.png"), forState: UIControlState.Normal)
        }else{
            audio.pause()
            btnPlay.setImage(UIImage(named: "play.png"), forState: UIControlState.Normal)
        }
        isPlaying = !isPlaying
        
    }
    
    @IBAction func slide(sender: UISlider) {
        print(sender.value)
        audio.volume = sender.value
    }
    
    func addThumbImgForSlider() {
        slide.setThumbImage(UIImage(named: "thumb.png"), forState: .Normal)
        
        slide.setThumbImage(UIImage(named: "thumbHightLight.png"), forState: .Highlighted)
        
    }
}

