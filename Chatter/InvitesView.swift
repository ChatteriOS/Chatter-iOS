//
//  InvitesView.swift
//  Chatter
//
//  Created by Austen Ma on 3/11/18.
//  Copyright © 2018 Austen Ma. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class InvitesView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var invitesTableView: UITableView!
    @IBOutlet weak var backToMenuButton: UIButton!
    
    var switchDelegate:SwitchMenuFriendsViewDelegate?
    
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set table row height
        invitesTableView.rowHeight = UITableViewAutomaticDimension
        invitesTableView.estimatedRowHeight = 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvitesTableViewCell") as! InvitesTableViewCell
        return cell
    }
    
    @IBAction func backToMenu() {
        backToMenuButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: 1.25,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.40),
                       initialSpringVelocity: CGFloat(6.0),
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        self.backToMenuButton.transform = CGAffineTransform.identity
        },
                       completion: { Void in()  }
        )
        
        switchDelegate?.SwitchMenuFriendsView(toPage: "menuView")
    }
}


