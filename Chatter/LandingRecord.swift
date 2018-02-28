//
//  LandingRecord.swift
//  Chatter
//
//  Created by Austen Ma on 2/27/18.
//  Copyright © 2018 Austen Ma. All rights reserved.
//

import Foundation
import UIKit
import Pulsator
import AVFoundation
import AudioToolbox

class LandingRecord: UIViewController {
    
    @IBOutlet weak var topNavView: UIView!
    @IBOutlet weak var recButtonCover: UIView!
    @IBOutlet weak var pulseView: UIView!
    @IBOutlet weak var recButton: UIButton!

    let pulsator = Pulsator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pulseView.layer.addSublayer(pulsator)
        pulsator.backgroundColor = UIColor(red: 0.75, green: 0, blue: 1, alpha: 1).cgColor
        
        topNavView.addBorder(toSide: .Bottom, withColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor, andThickness: 1.0)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidLayoutSubviews() {
        configureButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func animateRecButton(sender: UIButton) {
        
        if (!pulsator.isPulsating) {
            pulsator.numPulse = 6
            pulsator.animationDuration = 2
            pulsator.radius = 170.0
            pulsator.start()
        }   else {
            pulsator.stop()
        }
        
        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        UIView.animate(withDuration: 1.25,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.30),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }

    @IBAction func animateButton(sender: UIButton) {
        
        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        
        UIView.animate(withDuration: 1.25,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.30),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
    }

    //    UI Configuration --------------------------------------

    // Configures Circle Record Button
    func configureButton()
    {
        recButtonCover.layer.cornerRadius = 0.5 * recButtonCover.bounds.size.width
        recButtonCover.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha:0).cgColor as CGColor
        recButtonCover.layer.borderWidth = 2.0
        recButtonCover.clipsToBounds = true
    }

}
