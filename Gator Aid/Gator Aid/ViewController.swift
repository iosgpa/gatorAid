//
//  ViewController.swift
//  Gator Aid
//
//  Created by Kinderley Charles on 10/26/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

var currUserAdvisor = [PFObject]()
var currUserProfile = [PFObject]()
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Variable Declarations
    @IBOutlet var Menu: UIBarButtonItem!
    @IBOutlet weak var tabCourses: UITableView!
    @IBOutlet weak var currGpa: UILabel!
    @IBOutlet weak var msg1: UILabel!
    @IBOutlet weak var msg2: UILabel!
    var classEnrolled = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMenuButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        if(currUserAdvisor.count  == 0) {
            getCurrentUserAdvisor()
        }
        if (currUserProfile.count == 0) {
            getCurrentUserProfile()
        }
        self.printInfo()
    }
    
    func printInfo() {
        if(currUserProfile.count != 0 && currUserAdvisor.count != 0) {
            self.currGpa.text = String(currUserProfile[0]["currGPA"])
            self.msg1.text = "Your advisor is " + String(currUserAdvisor[0]["name"])
            self.msg2.text = String(currUserAdvisor[0]["location"]) + ", " + String(currUserAdvisor[0]["room"])
        }
    }
    
    // Define each row of the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCourseId", forIndexPath: indexPath)
        // Set the label of the cell
        return cell
    }
    
    // return the number of rows in the table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classEnrolled.count
    }
    
    // Initialize Menu button
    func initMenuButton() {
        // Menu.target = self.revealViewController()
        Menu.action = Selector("revealToggle:")
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
    @IBAction func Logout(sender: AnyObject) {
        PFUser.logOut()
        let startViewController = self.storyboard!.instantiateViewControllerWithIdentifier("StartUpPage")
        UIApplication.sharedApplication().keyWindow?.rootViewController = startViewController
    }

    // Get the advisor of the current logged in user
    func getCurrentUserAdvisor() {
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
    
    // Get the profile of the current user
    func getCurrentUserProfile() {
        let query:PFQuery = PFQuery(className: "Profile")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.limit = 1
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    currUserProfile.append(obj)
                }
            }
        }
    }
}

