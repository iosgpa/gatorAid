//
//  ViewController.swift
//  Gator Aid
//
//  Created by Kinderley Charles on 10/26/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

var Courses = [PFObject]()
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
        // If no user is logged in, redirect app to start up page
        if(PFUser.currentUser() == nil) {
            let startViewController = self.storyboard!.instantiateViewControllerWithIdentifier("StartUpPage")
            UIApplication.sharedApplication().keyWindow?.rootViewController = startViewController
        }
        
        initMenuButton()
        if( (PFUser.currentUser() != nil) && (currUserProfile.count == 0) ) {
            self.getCurrentUserProfile()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
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
    
    
    func getCourseTrack() {
        let query:PFQuery = PFQuery(className: "CourseTrack")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    currUserCourseTrack.append(obj)
                    if( (obj["currSched"] != nil) && (obj["currSched"] as! Bool == true) ) {
                        for o in Courses {
                            if( (o == obj["courses"] as! PFObject) && !currUserSchedule.contains(o) ) {
                                currUserSchedule.append(o)
                            }
                        }
                    }
                }
                self.tabCourses.reloadData()
                self.getCurrentUserMajor()
            }
        }
    }
    
    func getCurrentUserMajor() {
        let user  = PFUser.currentUser() as! PFObject
        let query:PFQuery = PFQuery(className: "Majors")
        query.whereKey("majorId", equalTo: user["majorId"])
        query.orderByAscending("semester")
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    currUserMajor.append(obj)
                }
                print("Major retrieved")
            }
        }
    }
    
    func getCourses() {
        let query:PFQuery = PFQuery(className: "Courses")
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    Courses.append(obj)
                }
                if(currUserCourseTrack.count == 0) {
                    self.getCourseTrack()
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
                if(Courses.count == 0) {
                    self.getCourses()
                }
                self.printInfo()
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
                if(currUserAdvisor.count == 0) {
                    self.getCurrentUserAdvisor()
                }
                self.printInfo()
            }
        }
    }
}

