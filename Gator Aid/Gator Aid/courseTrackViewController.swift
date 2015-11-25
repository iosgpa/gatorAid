//
//  courseTrackViewController.swift
//  Gator Aid
//
//  Created by Christian Young on 11/23/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

class courseTrackViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // UI Variable declarations
    @IBOutlet weak var Menu: UIBarButtonItem!
    @IBOutlet weak var msgText: UILabel!
    @IBOutlet weak var credit1: UITextField!
    @IBOutlet weak var credit2: UITextField!
    @IBOutlet weak var credit3: UITextField!
    @IBOutlet weak var credit4: UITextField!
    @IBOutlet weak var credit5: UITextField!
    @IBOutlet weak var credit6: UITextField!
    @IBOutlet weak var desiredGPA: UITextField!
    var pickCredit = ["1.0", "2.0", "3.0", "4.0", "5.0"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initMenuButton()
        
        var cPickerView1 = UIPickerView()
        var cPickerView2 = UIPickerView()
        var cPickerView3 = UIPickerView()
        var cPickerView4 = UIPickerView()
        var cPickerView5 = UIPickerView()
        var cPickerView6 = UIPickerView()
        
        cPickerView1.delegate = self
        cPickerView2.delegate = self
        cPickerView3.delegate = self
        cPickerView4.delegate = self
        cPickerView5.delegate = self
        cPickerView6.delegate = self
        
        credit1.inputView = cPickerView1
        credit2.inputView = cPickerView2
        credit3.inputView = cPickerView3
        credit4.inputView = cPickerView4
        credit5.inputView = cPickerView5
        credit6.inputView = cPickerView6
        
        cPickerView1.tag = 0
        cPickerView2.tag = 1
        cPickerView3.tag = 2
        cPickerView4.tag = 3
        cPickerView5.tag = 4
        cPickerView6.tag = 5
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return pickCredit.count
        }
        else if pickerView.tag == 1 {
            return pickCredit.count
        }
        else if pickerView.tag == 2 {
            return pickCredit.count
        }
        else if pickerView.tag == 3 {
            return pickCredit.count
        }
        else if pickerView.tag == 4 {
            return pickCredit.count
        }
        else if pickerView.tag == 5 {
            return pickCredit.count
        }
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return pickCredit[row]
        }
        else if pickerView.tag == 1 {
            return pickCredit[row]
        }
        else if pickerView.tag == 2 {
            return pickCredit[row]
        }
        else if pickerView.tag == 3 {
            return pickCredit[row]
        }
        else if pickerView.tag == 4 {
            return pickCredit[row]
        }
        else if pickerView.tag == 5 {
            return pickCredit[row]
        }
        return ""
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            credit1.text = pickCredit[row]
        }
        else if pickerView.tag == 1 {
            credit2.text = pickCredit[row]
        }
        else if pickerView.tag == 2 {
            credit3.text = pickCredit[row]
        }
        else if pickerView.tag == 3 {
            credit4.text = pickCredit[row]
        }
        else if pickerView.tag == 4 {
            credit5.text = pickCredit[row]
        }
        else if pickerView.tag == 5 {
            credit6.text = pickCredit[row]
        }
        self.view.endEditing(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Logout(sender: AnyObject) {
        PFUser.logOut()
        let startViewController = self.storyboard!.instantiateViewControllerWithIdentifier("StartUpPage")
        UIApplication.sharedApplication().keyWindow?.rootViewController = startViewController
    }
    
    // Initialize Menu button
    func initMenuButton() {
        // Menu.target = self.revealViewController()
        Menu.action = Selector("revealToggle:")
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}
