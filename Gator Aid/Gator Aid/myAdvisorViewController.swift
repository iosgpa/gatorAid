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
    var currentUserProfile = [PFObject]()
    var advisor = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMenuButton()
        if currentUserProfile.count == 0 {
            getCurrentUserProfile()
        }
        if advisor.count == 0 {
            getAdvisor()
        }
        else { printInfo() }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar
        navigationItem.title = "My advisor"
    }
    
    // Initialize Menu button
    func initMenuButton() {
        // Menu.target = self.revealViewController()
        Menu.action = Selector("revealToggle:")
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    // This function gets the profile of the current selected user
    func getCurrentUserProfile() {
        let query:PFQuery = PFQuery(className: "Profile")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.limit = 1
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    self.currentUserProfile.append(obj)
                    self.getAdvisor()
                }
            }
        }
    }
    
    func getAdvisor() {
        let query:PFQuery = PFQuery(className: "Advisors")
        query.whereKey("phone", equalTo: "3523921090")
        query.limit = 1
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    self.advisor.append(obj)
                    self.viewDidLoad()
                }
            }
        }
    }
    
    
    
    func printInfo() {
        advName.text = String("Kinderley")
    }
}
