//
//  ViewController.swift
//  Video Background
//
//  Created by Kai Schaller on 3/11/15.
//  Copyright (c) 2015 Kai Schaller. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    var moviePlayer: AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the video from the app bundle.
        let videoURL: NSURL = NSBundle.mainBundle().URLForResource("video", withExtension: "mov")!
        
        self.moviePlayer = AVPlayer(URL: videoURL)
        self.moviePlayer.muted = true //unmute if you want
        
        let playerLayer = AVPlayerLayer(player: self.moviePlayer)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1

        playerLayer.frame = self.view.frame

        self.view.layer.addSublayer(playerLayer)

        self.moviePlayer.play()
            
        //loop video
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "loopVideo",
            name: AVPlayerItemDidPlayToEndTimeNotification,
            object: self.moviePlayer.currentItem)
     }
    
    func loopVideo() {
        self.moviePlayer.seekToTime(kCMTimeZero)
        self.moviePlayer.play()
    }

}

