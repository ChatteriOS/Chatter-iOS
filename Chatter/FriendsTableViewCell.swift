//
//  FriendsTableViewCell.swift
//  Chatter
//
//  Created by Austen Ma on 3/12/18.
//  Copyright © 2018 Austen Ma. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FriendsTableViewCell: UITableViewCell {
    @IBOutlet weak var friendAvatarButton: UIButton!
    @IBOutlet weak var friendUsernameLabel: UILabel!
    
    var ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
}
