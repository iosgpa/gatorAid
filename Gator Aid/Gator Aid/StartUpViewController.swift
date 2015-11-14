//
//  StartUpViewController.swift
//  Gator Aid
//
//  Created by Kinderley Charles on 11/14/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit

class StartUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector.init("goToSignIn"), userInfo: nil, repeats: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func goToSignIn() {
        print("Going to Sign In from StartUp page")
        let nextView:signInViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SignIn") as! signInViewController
        self.presentViewController(nextView, animated: true, completion: nil)
    }

}
