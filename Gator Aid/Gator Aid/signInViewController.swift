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
                            self.getCurrentUserInfo()
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
    
    func getCurrentUserInfo() {
        let user  = PFUser.currentUser() as! PFObject
        // Find User Profile
        let queryProfile = PFQuery(className: "Profile")
        queryProfile.whereKey("user", equalTo: PFUser.currentUser()!)
        queryProfile.limit = 1
        queryProfile.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    currUserProfile.append(obj)
                    self.getCurrentUserAdvisor()
                }
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
                        self.getCurrentUserMajor()
                    }
                }
            }
            else {
                self.printInfo("Cannot retrieve user's advisor")
            }
        }
    }
    
    // Get the profile of the current user
    func getCurrentUserMajor() {
        let user  = PFUser.currentUser() as! PFObject
        let query:PFQuery = PFQuery(className: "Majors")
        query.findObjectsInBackgroundWithBlock{ (objects: [PFObject]?, error: NSError?) -> Void in
            if error == nil {
                for obj in objects! {
                    if(obj == user["decMajor"] as! PFObject) {
                        currUserProfile.append(obj)
                        print(obj)
                        self.goHome()
                    }
                }
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
        performSegueWithIdentifier("signIn2Home", sender: nil)
    }
}
