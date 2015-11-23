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
                            self.getCurrentUserAdvisor()
                            self.goHome()
                        }
                        else {
                            print(error?.description)
                        }
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
    
    // Proceed to Home page if the user is already logged in or user meet login credentials
    func goHome() {
        performSegueWithIdentifier("signIn2Home", sender: nil)
    }
}
