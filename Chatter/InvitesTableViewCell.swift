//
//  InvitationsTableCell.swift
//  Chatter
//
//  Created by Austen Ma on 3/11/18.
//  Copyright © 2018 Austen Ma. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class InvitesTableViewCell: UITableViewCell {
    @IBOutlet weak var inviterUsernameLabel: UILabel!
    @IBOutlet weak var inviteDenyButton: UIButton!
    @IBOutlet weak var inviteAcceptButton: UIButton!
    
    var inviterID: String!
    let userID = Auth.auth().currentUser?.uid
    
    @IBAction func acceptInvitation(sender: UIButton) {
        print(self.inviterID)
        
        // USE InviterID and UserID to exchange friend list data
        // Popup modal to show invitation accepted
        // Delete Invitation
    }
    
    @IBAction func denyInvitation(sender: UIButton) {
        print(self.inviterID)
        
        // Delete Invitation
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
}
