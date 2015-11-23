//
//  myAdvisorViewController.swift
//  Gator Aid
//
//  Created by Christian Young on 11/12/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

class myAdvisorViewController: UIViewController {

    // UI Variables definitions
    @IBOutlet weak var advName: UILabel!
    @IBOutlet weak var college: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var emailAddr: UILabel!
    @IBOutlet weak var webAddr: UILabel!
    @IBOutlet weak var bldLoc: UILabel!
    @IBOutlet weak var roomNum: UILabel!
    @IBOutlet weak var officeHr: UILabel!
    @IBOutlet weak var advisingMes: UILabel!
    @IBOutlet weak var noteFromAdv: UILabel!
    @IBOutlet var Menu:UIBarButtonItem!
    
    // Locally declared variables
    var advisor = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMenuButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        if (PFUser.currentUser() != nil && currUserAdvisor.count == 0) {
            self.getAdvisor()
            self.printInfo()
        }
        else if (PFUser.currentUser() != nil) {
            self.printInfo()
        }
        else {}
    }
    
    @IBAction func Logout(sender: AnyObject) {
        PFUser.logOut()
        let startViewController = self.storyboard!.instantiateViewControllerWithIdentifier("StartUpPage")
        UIApplication.sharedApplication().keyWindow?.rootViewController = startViewController
    }
    
    // Initialize Menu button
    func initMenuButton() {
        // Menu.target = self.revealViewController()
        Menu.action = Selector("revealToggle:")
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    // Get the current advisor
    func getAdvisor() {
        let tmp = PFUser.currentUser() as! PFObject
        let query:PFQuery = PFQuery(className: "Advisors")
        query.whereKey("objectId", equalTo: tmp["advisor"].objectId!!)
        query.limit = 1
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    currUserAdvisor.append(obj)
                }
            }
        }
    }
    
    // Print the function
    func printInfo() {
        if(currUserAdvisor.count != 0) {
            advName.text = String(currUserAdvisor[0]["name"])
            college.text = String(currUserAdvisor[0]["college"])
            phone.text = String(currUserAdvisor[0]["phone"])
            emailAddr.text = String(currUserAdvisor[0]["email"])
            webAddr.text = String(currUserAdvisor[0]["website"])
            bldLoc.text = String(currUserAdvisor[0]["location"])
            roomNum.text = String(currUserAdvisor[0]["room"])
            officeHr.text = String(currUserAdvisor[0]["officeHr"])
            noteFromAdv.text = "Note from " + String(currUserAdvisor[0]["name"])
            advisingMes.text = String(currUserAdvisor[0]["message"])
        }
    }
}
