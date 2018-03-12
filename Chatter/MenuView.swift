//
//  MenuViewController.swift
//  Chatter
//
//  Created by Austen Ma on 3/11/18.
//  Copyright © 2018 Austen Ma. All rights reserved.
//

import Foundation
import UIKit
import Firebase

protocol SwitchMenuFriendsViewDelegate
{
    func SwitchMenuFriendsView(toPage: String)
}

protocol SwitchMenuInvitesViewDelegate
{
    func SwitchMenuInvitesView(toPage: String)
}

class MenuView: UIViewController {
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userAvatarButton: UIButton!
    
    // Initialize FB storage + DB
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser?.uid
    
    var switchMenuFriendsDelegate:SwitchMenuFriendsViewDelegate?
    var switchMenuInvitesDelegate:SwitchMenuInvitesViewDelegate?
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        
        // Set user full name, username, and avatar button labels
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            let firstname = value?["firstname"] as? String ?? ""
            let lastname = value?["lastname"] as? String ?? ""
            
            self.fullNameLabel.text = firstname + " " + lastname
            
            let username = value?["username"] as? String ?? ""
            
            self.usernameLabel.text = "@" + username
            
            // Label Avatar button
            let firstnameLetter = String(describing: firstname.first!)
            self.userAvatarButton.setTitle(firstnameLetter, for: .normal)
            
            self.configureAvatarButton()
        })
    }
    
    @IBAction func goToFriends(sender: AnyObject) {
        switchMenuFriendsDelegate?.SwitchMenuFriendsView(toPage: "friendsView")
    }
    
    @IBAction func goToInvites(sender: AnyObject) {
        switchMenuInvitesDelegate?.SwitchMenuInvitesView(toPage: "invitesView")
    }
    
    func configureAvatarButton() {
        userAvatarButton.frame = CGRect(x: 18, y: 40, width: 40, height: 40)
        userAvatarButton.layer.cornerRadius = 0.5 * userAvatarButton.bounds.size.width
        userAvatarButton.clipsToBounds = true
        userAvatarButton.backgroundColor = UIColor(red: 179/255, green: 95/255, blue: 232/255, alpha: 1.0)
    }
}

