//
//  GPAGuesserViewController.swift
//  Gator Aid
//
//  Created by Kinderley Charles on 11/6/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

class GPAGuesserViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    // UI Variable declarations
    @IBOutlet weak var gpaMsg: UILabel!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var nav: UINavigationBar!
    @IBOutlet weak var Menu: UIBarButtonItem!
    @IBOutlet weak var background: UIImageView!
    var pickGrade = ["A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "E"]
    var pickCredit = ["1.0", "2.0", "3.0", "4.0", "5.0"]
    @IBOutlet var grade1: UITextField!
    @IBOutlet var grade2: UITextField!
    @IBOutlet var grade3: UITextField!
    @IBOutlet var grade4: UITextField!
    @IBOutlet var grade5: UITextField!
    @IBOutlet var grade6: UITextField!
    @IBOutlet var credit1: UITextField!
    @IBOutlet var credit2: UITextField!
    @IBOutlet var credit3: UITextField!
    @IBOutlet var credit4: UITextField!
    @IBOutlet var credit5: UITextField!
    @IBOutlet var credit6: UITextField!
    
    
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
        var pickerView = UIPickerView()
        
        pickerView.delegate = self
        
        grade1.inputView = pickerView
        /*grade2.inputView = pickerView
        grade3.inputView = pickerView
        grade4.inputView = pickerView
        grade5.inputView = pickerView
        grade6.inputView = pickerView
        credit1.inputView = pickerView
        credit2.inputView = pickerView
        credit3.inputView = pickerView
        credit4.inputView = pickerView
        credit5.inputView = pickerView
        credit6.inputView = pickerView*/
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickGrade.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickGrade[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        grade1.text = pickGrade[row]
    }
    
    // Initialize Menu button
    func initMenuButton() {
        // Menu.target = self.revealViewController()
        Menu.action = Selector("revealToggle:")
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
}
