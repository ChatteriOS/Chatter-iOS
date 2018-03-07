//
//  ChatterFeed.swift
//  Chatter
//
//  Created by Austen Ma on 2/28/18.
//  Copyright © 2018 Austen Ma. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol SwitchRecChatterViewDelegate
{
    func SwitchRecChatterView(toPage: String)
}

class ChatterFeed: UIViewController {
    @IBOutlet weak var chatterScrollView: UIScrollView!
    @IBOutlet var chatterFeedView: UIView!
    
    var ref: DatabaseReference!
    let storage = Storage.storage()
    
    var switchDelegate:SwitchRecChatterViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        let storageRef = storage.reference()
        let userID = Auth.auth().currentUser?.uid
        
        var chatterSegmentArray: [URL] = []
        let constructionGroup = DispatchGroup()
        
        // Setting up UI Constructors --------------------------------------------------------------------------
        chatterScrollView.contentSize = chatterFeedView.frame.size
        
        let imageWidth:CGFloat = 300
        var imageHeight:CGFloat = 300
        var yPosition:CGFloat = 0
        var scrollViewContentSize:CGFloat=0;

        // CHANGE THIS TO OBSERVE ONCE ***********************************************************************
        // Upon initialization, this will fire for EACH child in chatterFeed, and observe for each NEW -------------------------------------
        self.ref.child("users").child(userID!).child("chatterFeed").observe(.childAdded, with: { (snapshot) -> Void in
            constructionGroup.enter()
            // ************* Remember to add conditional to filter/delete based on date **************
            
            let value = snapshot.value as? NSDictionary
            
            let id = value?["id"] as? String ?? ""
            let userDetails = value?["userDetails"] as? String ?? ""
            
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let localURL = documentsURL.appendingPathComponent("\(id.suffix(10)).m4a")
            
            let newView = ChatterFeedSegmentView()
            newView.layer.borderWidth = 1
            newView.layer.borderColor = UIColor.purple.cgColor
            newView.contentMode = UIViewContentMode.scaleAspectFit
            newView.frame.size.width = imageWidth
            newView.frame.size.height = imageHeight
            newView.center = self.view.center
            newView.frame.origin.y = yPosition
            
            // Generate audio file on UIView instance
            newView.generateAudioFile(audioURL: localURL, id: id)
            
            self.chatterScrollView.addSubview(newView)
            let spacer:CGFloat = 0
            yPosition+=imageHeight + spacer
            scrollViewContentSize+=imageHeight + spacer
            
            // Calculates running total of how long the scrollView needs to be with the variables
            self.chatterScrollView.contentSize = CGSize(width: imageWidth, height: scrollViewContentSize)
            
            imageHeight = 300
            
            // Add to array for
            constructionGroup.leave()
        })
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { // change 1 to desired number of seconds
            print("INITIAL CHATTER FEED ARRAY: \(chatterSegmentArray)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("DEINITIALIZING")
        let userID = Auth.auth().currentUser?.uid
        self.ref.child("users").child(userID!).child("chatterFeed").removeAllObservers()
    }
    
    @IBAction func animateButton(sender: UIButton) {
        
        sender.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 1.25,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        sender.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
        
        switchDelegate?.SwitchRecChatterView(toPage: "recordView")
    }
}
