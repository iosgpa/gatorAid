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
    @IBOutlet var Menu:UIBarButtonItem!
    
    // Locally declared variables
    var advisor = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMenuButton()
        if PFUser.currentUser() != nil {
            self.getAdvisor()
        }
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
    
    // Get the current advisor
    func getAdvisor() {
        let tmp = PFUser.currentUser() as! PFObject
        let query:PFQuery = PFQuery(className: "Advisors")
        query.whereKey("objectId", equalTo: tmp["advisor"].objectId!!)
        query.limit = 1
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    self.advisor.append(obj)
                    self.printInfo()
                }
            }
        }
    }
    
    // Print the function
    func printInfo() {
        advName.text = String(advisor[0]["name"])
        college.text = String(advisor[0]["college"])
        phone.text = String(advisor[0]["phone"])
        emailAddr.text = String(advisor[0]["email"])
        webAddr.text = String(advisor[0]["website"])
        bldLoc.text = String(advisor[0]["location"])
        roomNum.text = String(advisor[0]["room"])
        officeHr.text = String(advisor[0]["officeHr"])
        advisingMes.text = String(advisor[0]["message"])
    }
}
