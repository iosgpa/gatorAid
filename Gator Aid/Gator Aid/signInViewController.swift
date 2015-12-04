//
//  signInViewController.swift
//  Gator Aid
//
//  Created by Christian Young on 11/12/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

class signInViewController: UIViewController {

    // UI variables declarations
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errMsg: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (PFUser.currentUser() != nil) {
            // Skip login section if user is already logged in
            self.goHome()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Check user login credentials and proceed to log in the user
    @IBAction func Login(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground (username.text!, password:password.text!) {
            (user: PFUser?, Error: NSError?) -> Void in
            if user != nil {
                // Check the credentials of the user
                if (self.username.text != "" && self.password.text != "") {
                    PFUser.logInWithUsernameInBackground(self.username.text!, password:self.password.text!) {
                        (user: PFUser?, error: NSError?) -> Void in
                        if user != nil {
                            print("You logged in")
                            self.getCurrentUserProfile()
                        }
                        else {
                            print("Invalid Login entry")
                        }
                    }
                }
            }
            else {
                self.printInfo("Invalid Login entry")
            }
        }
    }
    
    func getCurrentUserProfile() {
        // Find User Profile
        let queryProfile = PFQuery(className: "Profile")
        queryProfile.whereKey("user", equalTo: PFUser.currentUser()!)
        queryProfile.limit = 1
        queryProfile.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    currUserProfile.append(obj)
                }
                print("Profile retrieved")
                self.getCurrentUserAdvisor()
            }
            else {
                self.printInfo("Cannot retrieve user profile")
            }
        }
    }
    
    
    
    // Get the advisor of the current logged in user
    func getCurrentUserAdvisor() {
        let user  = PFUser.currentUser() as! PFObject
        let query:PFQuery = PFQuery(className: "Advisors")
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    if(obj == user["advisor"] as! PFObject) {
                        currUserAdvisor.append(obj)
                        print("Advisor retrieved")
                        self.getCurrentUserMajor()
                    }
                }
                
            }
            else {
                self.printInfo("Cannot retrieve user's advisor")
            }
        }
    }
    
    // Get major of the current user
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
                self.getAllCourses()
            }
            else {
                self.printInfo("Cannot retrieve user's major")
            }
        }
    }
    
    func getAllCourses() {
        let query:PFQuery = PFQuery(className: "Courses")
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    Courses.append(obj)
                }
                print("Courses retrieved")
                self.getCurrentUserCourseTrack()
            }
            else {
                self.printInfo("Cannot retrieve list of courses")
            }
        }
    }
    
    func getCurrentUserCourseTrack() {
        let query:PFQuery = PFQuery(className: "CourseTrack")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    currUserCourseTrack.append(obj)
                    if( (obj["currSched"] != nil) && (obj["currSched"] as! Bool == true) ) {
                        for o in Courses {
                            if( (obj["courses"] as! PFObject == o) && !currUserSchedule.contains(o) ) {
                                currUserSchedule.append(o)
                            }
                        }
                    }
                }
                print("Course track and current schedule retrieved")
                self.goHome()
            }
            else {
                self.printInfo("Cannot retrieve user's major")
            }
        }
    }
    
    
    func printInfo(msg:String) {
        if(msg != "") {
            errMsg.text = msg
        }
    }
    
    // Proceed to Home page if the user is already logged in or user meet login credentials
    func goHome() {
        print("TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST TEST ")
        print("*******************************************************")
        print(currUserProfile)
        print(currUserSchedule)
        print(currUserAdvisor)
        print(currUserMajor)
        print(currUserCourseTrack)
        print(Courses)
        print("*******************************************************\n")
        performSegueWithIdentifier("signIn2Home", sender: nil)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
}
