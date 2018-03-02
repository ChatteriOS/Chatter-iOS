//
//  ChatterFeed.swift
//  Chatter
//
//  Created by Austen Ma on 2/28/18.
//  Copyright © 2018 Austen Ma. All rights reserved.
//

import Foundation
import UIKit

protocol SwitchRecChatterViewDelegate
{
    func SwitchRecChatterView(toPage: String)
}

class ChatterFeed: UIViewController {
    @IBOutlet weak var chatterScrollView: UIScrollView!
    @IBOutlet var chatterFeedView: UIView!
    
    var switchDelegate:SwitchRecChatterViewDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rectangle1 = UIView()
        rectangle1.layer.borderWidth = 1
        rectangle1.layer.borderColor = UIColor.purple.cgColor
        
        let rectangle2 = UIView()
        rectangle2.layer.borderWidth = 1
        rectangle2.layer.borderColor = UIColor.purple.cgColor
    
        let rectangle3 = UIView()
        rectangle3.layer.borderWidth = 1
        rectangle3.layer.borderColor = UIColor.purple.cgColor
        
        let rectangle4 = UIView()
        rectangle4.layer.borderWidth = 1
        rectangle4.layer.borderColor = UIColor.purple.cgColor
        
        let rectangle5 = UIView()
        rectangle5.layer.borderWidth = 1
        rectangle5.layer.borderColor = UIColor.purple.cgColor
        
        let rectangle6 = UIView()
        rectangle6.layer.borderWidth = 1
        rectangle6.layer.borderColor = UIColor.purple.cgColor
        
        // Have an array of views
        let myViews = [rectangle1, rectangle2, rectangle3, rectangle4, rectangle5, rectangle6]
        
        chatterScrollView.contentSize = chatterFeedView.frame.size
        
        let imageWidth:CGFloat = 300
        var imageHeight:CGFloat = 50
        var yPosition:CGFloat = 0
        var scrollViewContentSize:CGFloat=0;
        for view in myViews
        {
            // Test: Inputting Invisible Slider
//            let customSlider = CustomSlider()
//            customSlider.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2))
//            customSlider.center = self.view.center
//            customSlider.frame.origin.y = yPosition
            
            imageHeight = imageHeight + CGFloat(arc4random_uniform(250))
            view.contentMode = UIViewContentMode.scaleAspectFit
            view.frame.size.width = imageWidth
            view.frame.size.height = imageHeight
            view.center = self.view.center
            view.frame.origin.y = yPosition
            chatterScrollView.addSubview(view)
//            chatterScrollView.addSubview(customSlider)
            let spacer:CGFloat = 5
            yPosition+=imageHeight + spacer
            scrollViewContentSize+=imageHeight + spacer
            
            // Calculates running total of how long the scrollView needs to be with the variables
            chatterScrollView.contentSize = CGSize(width: imageWidth, height: scrollViewContentSize)
            
            imageHeight = 100
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
        
        switchDelegate?.SwitchRecChatterView(toPage: "recordView")
    }
}
