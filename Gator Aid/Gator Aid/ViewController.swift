//
//  ViewController.swift
//  Gator Aid
//
//  Created by Kinderley Charles on 10/26/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Variable Declarations
    @IBOutlet var Menu: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMenuButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Initialize Menu button
    func initMenuButton() {
        // Menu.target = self.revealViewController()
        Menu.action = Selector("revealToggle:")
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }

}

