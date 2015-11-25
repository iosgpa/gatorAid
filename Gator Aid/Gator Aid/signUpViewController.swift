//
//  signUpViewController.swift
//  Gator Aid
//
//  Created by Christian Young on 11/12/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

class signUpViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // UI variables
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPass: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var confirmEmail: UITextField!
    @IBOutlet weak var major: UITextField!
    @IBOutlet weak var msg: UILabel!
    var pickMajor = ["Computer Engineering", "Computer Science", "Electrical Engineering"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var mPickerView = UIPickerView()
        
        mPickerView.delegate = self
        
        major.inputView = mPickerView
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickMajor.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickMajor[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        major.text = pickMajor[row]
        self.view.endEditing(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
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
            confirmEmail.text == "" || major.text == "") {
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
            self.createUserProfile()
            
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
    
    func createUserProfile() {
        let advisor = PFObject(className: "Profile")
    }
    
    
    func goHome() {
        print("Going Home from Sign Up")
        performSegueWithIdentifier("signUp2Home", sender: nil)
    }
}
