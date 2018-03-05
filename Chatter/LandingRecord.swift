//
//  LandingRecord.swift
//  Chatter
//
//  Created by Austen Ma on 2/27/18.
//  Copyright © 2018 Austen Ma. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AudioToolbox
import UICircularProgressRing

protocol MenuActionDelegate {
    func openSegue(_ segueName: String, sender: AnyObject?)
    func reopenMenu()
}

protocol SwitchChatterButtonToUtilitiesDelegate
{
    func SwitchChatterButtonToUtilities(toFunction: String)
}

class LandingRecord: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate{
    
    @IBOutlet weak var topNavView: UIView!
    @IBOutlet weak var recButton: UIButton!
    @IBOutlet weak var recordingFilters: UIScrollView!
    @IBOutlet weak var circularProgressRing: UICircularProgressRingView!
    
    
    var switchDelegate:SwitchChatterButtonToUtilitiesDelegate?
    
    var isRecording = false
    var audioRecorder: AVAudioRecorder?
    var player : AVAudioPlayer?
    var finishedRecording = false

    let interactor = Interactor()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topNavView.addBorder(toSide: .Bottom, withColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor, andThickness: 1.0)
        self.recordingFilters.alpha = 0.0
        
        // Notification center, listening for recording utilities actions
        NotificationCenter.default.addObserver(self, selector: #selector(trashRecording(notification:)), name: .trashing, object: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidLayoutSubviews() {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startRecord(sender: AnyObject) {
    
        if (!finishedRecording) {
            if (sender.state == UIGestureRecognizerState.began) {
                
                // Toggle on utilities
                switchDelegate?.SwitchChatterButtonToUtilities(toFunction: "recording")
                
                // Code to start recording
                startRecording()
                
                self.circularProgressRing.setProgress(value: 100, animationDuration: 30.0) {
                    print("RECORD TIME REACHED.")
                    self.circularProgressRing.setProgress(value: 0, animationDuration: 0.1) {
                        print("FINISHED RECORDING.")
                        UIView.animate(withDuration: 0.5, animations: {
                            self.recordingFilters.alpha = 1.0
                        })
                        
                        //Code to stop recording
                        self.finishRecording()
                        self.finishedRecording = true
                        
                        // Code to start playback
                        self.playSound()
                    }
                }
            }   else if (sender.state == UIGestureRecognizerState.ended && !finishedRecording) {
                
                // Case if recording ends before time limit
                self.circularProgressRing.setProgress(value: 0, animationDuration: 0.1) {
                    print("FINISHED RECORDING.")
                    UIView.animate(withDuration: 0.5, animations: {
                        self.recordingFilters.alpha = 1.0
                    })
                    
                    //Code to stop recording
                    self.finishRecording()
                    self.finishedRecording = true
                    
                    // Code to start playback
                    self.playSound()
                }
            }
        }
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
    
    @IBAction func openMenu(sender: AnyObject) {
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
    
    @IBAction func edgePanGesture(_ sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .right)
        
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor){
                self.performSegue(withIdentifier: "openMenu", sender: nil)
        }
    }
    
    @IBAction func saveRecording(sender: AnyObject) {
        print("SAVING")
        if (finishedRecording) {
            // Saving animation
            recButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: 1.5,
                           delay: 0,
                           usingSpringWithDamping: CGFloat(0.6),
                           initialSpringVelocity: CGFloat(50.0),
                           options: UIViewAnimationOptions.allowUserInteraction,
                           animations: {
                            self.recButton.transform = CGAffineTransform.identity
            },
                           completion: { Void in()  }
            )
        
            // Return to recording view
            UIView.animate(withDuration: 0.5, animations: {
                self.recordingFilters.alpha = 0.0
            })
            // Stop the looping
            self.player?.stop()
        
            // Trash the recording
            switchDelegate?.SwitchChatterButtonToUtilities(toFunction: "finished")
        
            // Reset recording
            finishedRecording = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? Profile {
            destinationViewController.transitioningDelegate = self
            destinationViewController.interactor = interactor
            destinationViewController.menuActionDelegate = self
        }
    }
    
    //    Audio Recording ---------------------------------------
    
    func startRecording() {
        //1. create the session
        let session = AVAudioSession.sharedInstance()
        
        do {
            // 2. configure the session for recording and playback
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try session.setActive(true)
            // 3. set up a high-quality recording session
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            // 4. create the audio recording, and assign ourselves as the delegate
            audioRecorder = try AVAudioRecorder(url: getAudioFileUrl(), settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
        }
        catch let error {
            print("Failed to record!!!")
        }
    }
    
    func getAudioFileUrl() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let audioUrl = docsDirect.appendingPathComponent("currentRecording.m4a")
        return audioUrl
    }
    
    func finishRecording() {
        audioRecorder?.stop()
        isRecording = false
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            finishRecording()
        }else {
            // Recording interrupted by other reasons like call coming, reached time limit.
        }
    }
    
    // Audio Playback ------------------------------------------------
    
    func playSound(){
        let url = getAudioFileUrl()
        do {
            // AVAudioPlayer setting up with the saved file URL
            let sound = try AVAudioPlayer(contentsOf: url)
            self.player = sound
            
            // Here conforming to AVAudioPlayerDelegate
            sound.delegate = self
            sound.prepareToPlay()
            sound.numberOfLoops = -1
            sound.play()
        } catch {
            print("error loading file")
            // couldn't load file :(
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            
        }else {
            // Playing interrupted by other reasons like call coming, the sound has not finished playing.
        }
    }
    
    // Recording Utilities ---------------------------------------------------------
    
    @objc func trashRecording(notification: NSNotification) {
        UIView.animate(withDuration: 0.5, animations: {
            self.recordingFilters.alpha = 0.0
        })
        isRecording = false
        
        // Stop the looping
        self.player?.stop()
        
        // Trash the recording
        switchDelegate?.SwitchChatterButtonToUtilities(toFunction: "finished")
        
        // Reset recording
        finishedRecording = false
    }

}

extension Notification.Name {
    static let trashing = Notification.Name("trashing")
}

extension LandingRecord: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

extension LandingRecord: MenuActionDelegate {
    func openSegue(_ segueName: String, sender: AnyObject?) {
        dismiss(animated: true){
            self.performSegue(withIdentifier: segueName, sender: sender)
        }
    }
    func reopenMenu(){
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
}
