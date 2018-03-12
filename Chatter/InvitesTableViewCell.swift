//
//  InvitationsTableCell.swift
//  Chatter
//
//  Created by Austen Ma on 3/11/18.
//  Copyright © 2018 Austen Ma. All rights reserved.
//

import Foundation
import UIKit

class InvitesTableViewCell: UITableViewCell {
    @IBOutlet weak var inviterUsernameLabel: UILabel!
    @IBOutlet weak var inviteDenyButton: UIButton!
    @IBOutlet weak var inviteAcceptButton: UIButton!
    
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
