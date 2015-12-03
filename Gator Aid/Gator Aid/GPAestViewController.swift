//
//  GPAestViewController.swift
//  Gator Aid
//
//  Created by Cabrera,Kenneth on 12/2/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

class GPAestViewController: UIViewController {

    @IBOutlet var Menu: UIBarButtonItem!
    @IBOutlet weak var gpaout: UILabel!
    @IBOutlet weak var credits: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initMenuButton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Initialize Menu button
    func initMenuButton() {
        // Menu.target = self.revealViewController()
        Menu.action = Selector("revealToggle:")
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    @IBAction func Calculate(sender: AnyObject) {
        var totalcredit = currUserProfile[currUserProfile.count - 1]["hours"] as! Double
        var commcredit = currUserProfile[currUserProfile.count - 1]["currGPA"] as! Double
        var target = 4.00           // Target gpa
        
        var target1 = 4.00
        
        if(credits.text == "")
        {
            gpaout.text = "Enter proper input"
        }
        else
        {
            var input = Double(credits.text!)
            
            var totalcredit1 = totalcredit + input!
            
            target = target * totalcredit1
            
            var creditdiff = (target - (commcredit * totalcredit))
            
            
            var check = creditdiff / input!
            
            if(check > 4.000)
            {
                gpaout.text = "It is currently not possible to reach the target GPA (" + String(format: "%.2f", target1) + ") by next seemester, current max is " + String(format: "%.2f", (((input! * 4) + (commcredit * totalcredit)) / totalcredit1))
            }
            else
            {
                gpaout.text = String(format: "%.2f", check)
            }
            
        }
        
    }

    @IBAction func Logout(sender: AnyObject) {
        PFUser.logOut()
        let startViewController = self.storyboard!.instantiateViewControllerWithIdentifier("StartUpPage")
        UIApplication.sharedApplication().keyWindow?.rootViewController = startViewController
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

}
