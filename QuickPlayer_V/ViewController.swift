//
//  ViewController.swift
//  QuickPlayer_V
//
//  Created by Chung on 8/23/16.
//  Copyright © 2016 newayplus. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var my_Switch: UISwitch!
    var audio = AVAudioPlayer()
    var isPlaying = true
    var timer = NSTimer()
    
    
    
    @IBOutlet weak var slider_Duration: UISlider!
    @IBOutlet weak var maxDuration: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    @IBOutlet weak var slide: UISlider!
    @IBOutlet weak var btnPlay: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        audio.delegate = self
        audio = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music", ofType: ".mp3")!))
        audio.prepareToPlay()
        addThumbImgForSlider()
        my_Switch.addTarget(self, action: #selector(switchIsChange), forControlEvents: UIControlEvents.ValueChanged)
        let minu: Int = Int(audio.duration / 60)
        let sec: Int = Int(audio.duration % 60)
        if (sec < 10 && minu < 10){
            self.maxDuration.text = "0\(minu):0\(sec) "
            
        }else{
            if sec < 10 {
                self.maxDuration.text = "\(minu):0\(sec) "
            } else if minu < 10 {
                self.maxDuration.text = "0\(minu):\(sec) "
            }
            else{
                self.maxDuration.text = "\(minu):\(sec) "
            }
        }
        slider_Duration.maximumValue = Float(audio.duration)
    }
    
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        print("finish")
        btnPlay.setImage(UIImage(named: "play.png"), forState: UIControlState.Normal)
    }
    

    func updateFrame() {
        let minu: Int = Int(audio.currentTime / 60)
        let sec: Int = Int(audio.currentTime % 60)
        if (sec < 10 && minu < 10){
            self.duration.text = "0\(minu):0\(sec) "
            
        }else{
            if sec < 10 {
                self.duration.text = "\(minu):0\(sec) "
            } else if minu < 10 {
                self.duration.text = "0\(minu):\(sec) "
            }else{
                self.duration.text = "\(minu):\(sec) "
            }
            
        }
        

        slider_Duration.value = Float(audio.currentTime)
        
    }
    func switchIsChange(){
        if my_Switch.on {
            audio.numberOfLoops = -1
            btnPlay.setImage(UIImage(named: "pause.png"), forState: UIControlState.Normal)

        }else{
            audio.numberOfLoops = 0
        }
    }
    
    @IBAction func slider_Duration(sender: UISlider) {
        audio.stop()
        audio.currentTime = NSTimeInterval(slider_Duration.value)
        audio.prepareToPlay()
        audio.play()
    
    }
    
    @IBAction func btnPlay(sender: UIButton) {
        if isPlaying {
            audio.play()
            btnPlay.setImage(UIImage(named: "pause.png"), forState: UIControlState.Normal)
            timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(updateFrame), userInfo: nil, repeats: true)
            switchIsChange()
            
            
        }else{
            audio.pause()
            btnPlay.setImage(UIImage(named: "play.png"), forState: UIControlState.Normal)
            timer.invalidate()
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

