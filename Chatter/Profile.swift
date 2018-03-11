//
//  Profile.swift
//  Chatter
//
//  Created by Austen Ma on 2/26/18.
//  Copyright © 2018 Austen Ma. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Profile: UIViewController {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userAvatarButton: UIButton!
    
    var interactor:Interactor? = nil
    var menuActionDelegate:MenuActionDelegate? = nil
    let menuItems = ["First", "Second"]
    
    // Initialize FB storage + DB
    var ref: DatabaseReference!
    let userID = Auth.auth().currentUser?.uid
    
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
    
    @IBAction func handleGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .left)
        
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor){
                self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func closeMenu(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    func delay(seconds: Double, completion:@escaping ()->()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        dismiss(animated: true){
            self.delay(seconds: 0.5){
                self.menuActionDelegate?.reopenMenu()
            }
        }
    }
    
    func configureAvatarButton() {
        userAvatarButton.frame = CGRect(x: 18, y: 40, width: 40, height: 40)
        userAvatarButton.layer.cornerRadius = 0.5 * userAvatarButton.bounds.size.width
        userAvatarButton.clipsToBounds = true
        userAvatarButton.backgroundColor = UIColor(red: 179/255, green: 95/255, blue: 232/255, alpha: 1.0)
    }
    
}

extension Profile: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = menuItems[indexPath.row]
        return cell
    }
}

extension Profile: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            menuActionDelegate?.openSegue("openFirst", sender: nil)
        case 1:
            menuActionDelegate?.openSegue("openSecond", sender: nil)
        default:
            break
        }
    }
}

