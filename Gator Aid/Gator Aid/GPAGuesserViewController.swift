//
//  GPAGuesserViewController.swift
//  Gator Aid
//
//  Created by Kinderley Charles on 11/6/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

class GPAGuesserViewController: UIViewController {
    
    // UI Variable declarations
    @IBOutlet weak var gpaMsg: UILabel!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var nav: UINavigationBar!
    @IBOutlet weak var Menu: UIBarButtonItem!
    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.loadView()
        initMenuButton()
        if PFUser.currentUser() == nil {
            // Hide the navigation if no user is logged in
            self.nav.hidden = true
            self.cancel.enabled = true
            self.background.hidden = false
        }
        else {
            // Hide and diable the cancel button
            self.cancel.hidden = true
            self.cancel.enabled = false
            self.background.hidden = true
        }
    }
    
    // Initialize Menu button
    func initMenuButton() {
        // Menu.target = self.revealViewController()
        Menu.action = Selector("revealToggle:")
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
}
