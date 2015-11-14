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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ================================================================================
    // Remove before deployment
    func testLogin() {
        PFUser.logInWithUsernameInBackground ("test", password:"0000") {
            (user: PFUser?, Error: NSError?) -> Void in
            if user != nil {
                print("Successfully Logged in")
            }
            else {
                print("Login Failed")
            }
        }
    }
}
