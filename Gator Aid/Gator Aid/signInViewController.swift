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
    
    // Proceed to Home page if the user is already logged in or user meet login credentials
    func goHome() {
        performSegueWithIdentifier("signIn2Home", sender: nil)
    }
}
