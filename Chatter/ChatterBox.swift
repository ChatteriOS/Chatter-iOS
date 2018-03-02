//
//  Chatterbox.swift
//  Chatter
//
//  Created by Austen Ma on 3/1/18.
//  Copyright © 2018 Austen Ma. All rights reserved.
//

import Foundation
import UIKit

class ChatterBox: UIViewController {
    @IBOutlet weak var chatterScrollView: UIScrollView!
    @IBOutlet var chatterBoxView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rectangle1 = UIView()
        rectangle1.backgroundColor = UIColor.green
        
        let rectangle2 = UIView()
        rectangle2.backgroundColor = UIColor.red
        
        let rectangle3 = UIView()
        rectangle3.backgroundColor = UIColor.blue
        
        let rectangle4 = UIView()
        rectangle4.backgroundColor = UIColor.purple
        
        let rectangle5 = UIView()
        rectangle5.backgroundColor = UIColor.orange
        
        let rectangle6 = UIView()
        rectangle6.backgroundColor = UIColor.black
        
        // Have an array of views
        var myViews = [rectangle1, rectangle2, rectangle3, rectangle4, rectangle5, rectangle6]
        
        chatterScrollView.contentSize = chatterBoxView.frame.size
        
        let imageWidth:CGFloat = 300
        let imageHeight:CGFloat = 150
        var yPosition:CGFloat = 0
        var scrollViewContentSize:CGFloat=0;
        for view in myViews
        {
            view.contentMode = UIViewContentMode.scaleAspectFit
            view.frame.size.width = imageWidth
            view.frame.size.height = imageHeight
            view.center = self.view.center
            view.frame.origin.y = yPosition
            chatterScrollView.addSubview(view)
            let spacer:CGFloat = 5
            yPosition+=imageHeight + spacer
            scrollViewContentSize+=imageHeight + spacer
            chatterScrollView.contentSize = CGSize(width: imageWidth, height: scrollViewContentSize)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    }
}
