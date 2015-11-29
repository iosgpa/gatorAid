//
//  ViewController.swift
//  Gator Aid
//
//  Created by Kinderley Charles on 10/26/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

var currUserCourseTrack = [PFObject]()
var currUserMajor = [PFObject]()
var currUserAdvisor = [PFObject]()
var currUserProfile = [PFObject]()
var currUserSchedule = [PFObject]()
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Variable Declarations
    @IBOutlet var Menu: UIBarButtonItem!
    @IBOutlet weak var tabCourses: UITableView!
    @IBOutlet weak var currGpa: UILabel!
    @IBOutlet weak var msg1: UILabel!
    @IBOutlet weak var msg2: UILabel!
    var tmp = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMenuButton()
        if(currUserSchedule.count == 0 && PFUser.currentUser() != nil) {
            self.getCurrentUserSchedule()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        if(currUserAdvisor.count  == 0 && PFUser.currentUser() != nil) {
            getCurrentUserAdvisor()
        }
        if (currUserProfile.count == 0 && PFUser.currentUser() != nil) {
            getCurrentUserProfile()
        }
        self.printInfo()
    }
    
    func printInfo() {
        if(currUserProfile.count != 0 && currUserAdvisor.count != 0) {
            if (currUserProfile[0]["currGPA"] != nil) {
                self.currGpa.text = String(currUserProfile[0]["currGPA"])
            }
            else {
                self.currGpa.text = "0.00"
            }
            self.msg1.text = "Your advisor is " + String(currUserAdvisor[0]["name"])
            self.msg2.text = String(currUserAdvisor[0]["location"]) + ", " + String(currUserAdvisor[0]["room"])
        }
    }
    
    // Define each row of the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("homeCourseId", forIndexPath: indexPath)
        cell.textLabel?.text = String(currUserSchedule[indexPath.row]["courseName"])
        return cell
    }
    
    // return the number of rows in the table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currUserSchedule.count
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

    func getCurrentUserSchedule() {
        let query:PFQuery = PFQuery(className: "CourseTrack")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    self.tmp.append(obj["courses"] as! PFObject)
                }
                
                let query2:PFQuery = PFQuery(className: "Courses")
                query2.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
                    if error == nil {
                        for obj in objects! {
                            for o in self.tmp {
                                if obj == o {
                                    currUserSchedule.append(obj)
                                }
                            }
                        }
                        print(currUserSchedule)
                        self.tabCourses.reloadData()
                    }
                }
            }
        }
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

