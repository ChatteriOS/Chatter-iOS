//
//  AddFriendPopup.swift
//  Chatter
//
//  Created by Austen Ma on 3/11/18.
//  Copyright © 2018 Austen Ma. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class AddFriendModal: UIViewController {
    @IBOutlet weak var modalView: UIView!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up modal styling
        modalView.layer.cornerRadius = 5
        modalView.layer.borderWidth = 2
        modalView.layer.borderColor = UIColor(red: 179/255, green: 95/255, blue: 232/255, alpha: 1.0).cgColor
        
        // Initiate Firebase
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
    }
    
    @IBAction func sendInvite(sender: AnyObject) {
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            for user in value! {
                print("USER: \(user)")
            }
        })
        
        dismiss(animated: true, completion: nil)
    }
}

