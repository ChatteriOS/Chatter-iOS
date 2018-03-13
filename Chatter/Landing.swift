//
//  ViewController.swift
//  Chatter
//
//  Created by Austen Ma on 2/24/18.
//  Copyright © 2018 Austen Ma. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class Landing: UIViewController, SwitchRecChatterViewDelegate, SwitchChatterButtonToUtilitiesDelegate {
    @IBOutlet weak var recordView: UIView!
    @IBOutlet weak var chatterFeedView: UIView!
    @IBOutlet weak var chatterButton: UIButton!
    @IBOutlet weak var recordingUtilities: UIView!
    @IBOutlet weak var recordingUtilitiesTrashButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.recordingUtilities.alpha = 0.0
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ChatterFeed {
            destination.switchDelegate = self
        }
        
        if let destination = segue.destination as? LandingRecord {
            destination.switchDelegate = self
        }
    }
    
    @IBAction func hearChatter(sender: UIButton) {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        SwitchRecChatterView(toPage: "chatterView")
        
        // Notify ChatterFeed to start Chatter queue
        NotificationCenter.default.post(name: .queueNextChatter, object: nil)
    }
    
    @IBAction func animateButton(sender: UIButton) {
        
        sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 1.25,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.40),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }
    
    @IBAction func trashRecording(sender: UIButton) {
        NotificationCenter.default.post(name: .trashing, object: nil)
    }
    
    
    func SwitchRecChatterView(toPage: String) {
        if (toPage == "recordView") {
            UIView.animate(withDuration: 0.5, animations: {
                self.chatterFeedView.alpha = 0.0
                self.recordView.alpha = 1.0
            })
        }   else {
            UIView.animate(withDuration: 0.5, animations: {
                self.chatterFeedView.alpha = 1.0
                self.recordView.alpha = 0.0
            })
        }
    }
    
    func SwitchChatterButtonToUtilities(toFunction: String) {
        if (toFunction == "recording") {
            UIView.animate(withDuration: 0.5, animations: {
                self.chatterButton.alpha = 0.0
                self.recordingUtilities.alpha = 1.0
            })
        }   else if (toFunction == "finished") {
            UIView.animate(withDuration: 0.5, animations: {
                self.chatterButton.alpha = 1.0
                self.recordingUtilities.alpha = 0.0
            })
        }
    }
    
}

extension Notification.Name {
    static let trashing = Notification.Name("trashing")
    static let queueNextChatter = Notification.Name("queueNextChatter")
    static let chatterFinishedAndQueue = Notification.Name("chatterFinishedAndQueue")
    static let chatterChangedAndQueue = Notification.Name("chatterChangedAndQueue")
    
    // When invitation is accepted, updates Friends list
    static let invitationAcceptedRerenderFriends = Notification.Name("invitationAcceptedRerenderFriends")
}

