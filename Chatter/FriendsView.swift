//
//  FriendsViewController
//  Chatter
//
//  Created by Austen Ma on 3/11/18.
//  Copyright © 2018 Austen Ma. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class FriendsView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var backToMenuButton: UIButton!
    @IBOutlet weak var addFriendButton: UIButton!
    @IBOutlet weak var friendsTableView: UITableView!
    
    var switchDelegate:SwitchMenuFriendsViewDelegate?
    
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser?.uid
    
    var friendsLabelArray: [String]!
    var friendsIDArray: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        
        RerendeFriendsTableView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBackToMenu(sender: AnyObject) {
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
    
    func RerendeFriendsTableView() {
        self.friendsLabelArray = []
        self.friendsIDArray = []
        
        // Grab the invites array from DB
        self.ref.child("users").child(userID!).child("friends").observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            if (value != nil) {
                for user in value! {
                    print("Friend: \(user)")
                    let friendID = user.key as? String
                    
                    // Retrieve username with ID
                    self.ref.child("users").child(friendID!).child("username").observeSingleEvent(of: .value, with: { (snapshot) in
                        let friendUsername = snapshot.value as? String
                        
                        self.friendsLabelArray.append(friendUsername!)
                        self.friendsIDArray.append(friendID!)
                        
                        // Populate the Table View as the invitations are loaded
                        self.friendsTableView.reloadData()
                    })  { (error) in
                        print(error.localizedDescription)
                    }
                }
            }   else {
                self.friendsTableView.reloadData()
            }
        })  { (error) in
            print(error.localizedDescription)
        }
    }
    
    // Table View Methods --------------------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendsLabelArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 90.0;//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCell") as! FriendsTableViewCell
        
        // To turn off darken on select
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        // Allow button clicks on cells
        cell.contentView.isUserInteractionEnabled = true
        
        // Styling the Cell
        cell.frame.size.height = 100
        cell.friendUsernameLabel.text = friendsLabelArray[indexPath.row]
        let firstnameLetter = String(describing: friendsLabelArray[indexPath.row].first!).uppercased()
        cell.friendAvatarButton.setTitle(firstnameLetter, for: .normal)
        let randomColor = generateRandomColor()
        let currCellButton = cell.friendAvatarButton
        configureAvatarButton(button: currCellButton!, color: randomColor)
        return cell
    }
    
    func configureAvatarButton(button: UIButton, color: UIColor) {
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.clipsToBounds = true
        button.backgroundColor = color
    }
    
    func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.8 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
}

