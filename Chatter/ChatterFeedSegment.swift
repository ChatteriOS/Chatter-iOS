//
//  ChatterFeedSegment.swift
//  Chatter
//
//  Created by Austen Ma on 3/1/18.
//  Copyright © 2018 Austen Ma. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import AudioToolbox

class ChatterFeedSegmentView: UIView {
    var shouldSetupConstraints = true
    var recordingURL: URL!
    var playButton: UIButton!
    var player: AVAudioPlayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add play button
        let playButton = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
        playButton.addTarget(self, action: #selector(startPlay), for: .touchUpInside)
        playButton.backgroundColor = UIColor.gray
        self.addSubview(playButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func updateConstraints() {
        if(shouldSetupConstraints) {
            // AutoLayout constraints
            shouldSetupConstraints = false
        }
        super.updateConstraints()
    }
    
    @objc func startPlay() {
        self.playAudio()
    }
    
    func playAudio() {
        print("playing \(self.recordingURL)")
        
        do {
            player = try AVAudioPlayer(contentsOf: self.recordingURL)
            player?.prepareToPlay()
//            player?.volume = 10.0
            player?.play()
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
}
