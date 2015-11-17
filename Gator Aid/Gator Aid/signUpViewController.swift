//
//  signUpViewController.swift
//  Gator Aid
//
//  Created by Christian Young on 11/12/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

class signUpViewController: UIViewController {
    
    // UI variables
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmEmail: UITextField!
    @IBOutlet weak var msg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func printMessage(message: String) {
        msg.text = message;
    }
    
    // This function performs the necessary test and print a message to the user
    func isInfoValid() -> Bool {
        if (username.text == "" || password.text == "" ||
            confirmPass.text == "" || email.text == "" ||
            confirmEmail.text == "" ) {
                printMessage("One or more fields is missing")
                return false
        }
        if (password.text != confirmPass.text) {
            printMessage("Password confirmation does not match")
            return false
        }
        if (email.text != confirmEmail.text) {
            printMessage("Email confirmation does not match")
            return false
        }
        return true
    }
    
    @IBAction func SignUp(sender: AnyObject) {
        if (isInfoValid()) {
            // Create user
            let user = PFUser()
            user.username = username.text
            user.password = password.text
            user.email = email.text
            
            // Sign User in
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    let errorStr = error.userInfo["error"] as? NSString
                    print(errorStr)
                }
                else {
                    self.goHome()
                }
            }

        }
    }
    
    func goHome() {
        print("Going Home from Sign Up")
        performSegueWithIdentifier("signUp2Home", sender: nil)
    }
}
