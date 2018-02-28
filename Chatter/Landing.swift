//
//  ViewController.swift
//  Chatter
//
//  Created by Austen Ma on 2/24/18.
//  Copyright © 2018 Austen Ma. All rights reserved.
//

import UIKit
import AVFoundation
import Pulsator
import AudioToolbox

class Landing: UIViewController {
    @IBOutlet weak var chatterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        AVAudioSession.sharedInstance().requestRecordPermission () {
//            [unowned self] allowed in
//            if allowed {
//                // Microphone allowed, do what you like!
//                self.setUpUI()
//            } else {
//                // User denied microphone. Tell them off!
//
//            }
//        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMessage(sender: UIButton) {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
//    @IBAction func showMessage(sender: UIButton) {
//        let selectedButton = sender
//
//        if (selectedButton.titleLabel?.text) != nil {
//
//            let alertController = UIAlertController(title: "Welcome to My First App", message: "Clicked the button!", preferredStyle: UIAlertControllerStyle.alert)
//            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//            present(alertController, animated: true, completion: nil)
//
//        }
//    }
    
//    Audio Record Control --------------------------------------
    
//    var recordButton = UIButton()
//    var playButton = UIButton()
//    var isRecording = false
//    var audioRecorder: AVAudioRecorder?
//    var player : AVAudioPlayer?
//    
//    func setUpUI() {
//        recordButton.translatesAutoresizingMaskIntoConstraints = false
//        playButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(recordButton)
//        view.addSubview(playButton)
//        
//        // Adding constraints to Record button
//        recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        recordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        let recordButtonHeightConstraint = recordButton.heightAnchor.constraint(equalToConstant: 50)
//        recordButtonHeightConstraint.isActive = true
//        recordButton.widthAnchor.constraint(equalTo: recordButton.heightAnchor, multiplier: 1.0).isActive = true
//        recordButton.setImage(#imageLiteral(resourceName: "record"), for: .normal)
//        recordButton.layer.cornerRadius = recordButtonHeightConstraint.constant/2
//        recordButton.layer.borderColor = UIColor.white.cgColor
//        recordButton.layer.borderWidth = 5.0
//        recordButton.imageEdgeInsets = UIEdgeInsetsMake(-20, -20, -20, -20)
//        recordButton.addTarget(self, action: #selector(record(sender:)), for: .touchUpInside)
//        
//        // Adding constraints to Play button
//        playButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        playButton.widthAnchor.constraint(equalTo: playButton.heightAnchor, multiplier: 1.0).isActive = true
//        playButton.trailingAnchor.constraint(equalTo: recordButton.leadingAnchor, constant: -16).isActive = true
//        playButton.centerYAnchor.constraint(equalTo: recordButton.centerYAnchor).isActive = true
//        playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
//        playButton.addTarget(self, action: #selector(play(sender:)), for: .touchUpInside)
//    }
//    
//    @objc func record(sender: UIButton) {
//        
//    }
//    
//    @objc func play(sender: UIButton) {
//        
//    }
    
//    UI Configuration --------------------------------------
    
    // Configures Circle Record Button

}

