//
//  courseTrackViewController.swift
//  Gator Aid
//
//  Created by Christian Young on 11/23/15.
//  Copyright © 2015 Kinderley Charles. All rights reserved.
//

import UIKit
import Parse

class courseTrackViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return final.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        let (grd) = final [indexPath.row]
        
        
        cell.textLabel?.text = grd
        return cell
    }
    
    var final = [String]()
    var mess = "Please enter the credit hours of the courses you will be taking and your desired GPA."
    
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
    @IBOutlet weak var tableView: UITableView!
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
    
    @IBAction func doit(sender: AnyObject)
    {
        final.removeAll()
        msgText.text = mess
        var gpa = Double(desiredGPA.text!)
        
        var cgpa = String(format: "%.3f", gpa!)
        
        var grade: [String] = [ "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "F"]
        var value: [Double] = [4.00, 3.67, 3.33, 3.00, 2.67, 2.33, 2.00, 1.67, 1.33, 1.00, 0.67, 0]
        
        
        var str = ""
        var temp = 0.00
        
        var temp1 = 0.00
        var temp2 = 0.00
        var temp3 = 0.00
        var temp4 = 0.00
        var temp5 = 0.00
        var temp6 = 0.00
        
        var stemp = ""
        var sum = 0.00
        
        var a = 0
        var b = 0
        var c = 0
        var d = 0
        var e = 0
        var f = 0
        
        var i = 0
        var w = false
        var t = 0.00
        
        while(i < 5 && w == false)
        {
            if(credit1.text != "" && credit2.text == "")
            {
                sum = Double(credit1.text!)!
                for var a = 0; a < 12; ++a
                {
                    temp1 = Double(credit1.text!)! * value[a]
                    temp = (temp1)/sum
                    stemp = String(format: "%.3f", temp)
                    if(stemp < cgpa)
                    {
                        a = 12
                    }
                    if (stemp == cgpa)
                    {
                        str = grade[a]
                        final.append(str)
                        w = true
                    }
                }
            }
            else if(credit2.text != "" && credit3.text == "")
            {
                sum = Double(credit1.text!)! + Double(credit2.text!)!
                for var a = 0; a < 12; ++a
                {
                    for var b = 0; b < 12; ++b
                    {
                        temp1 = Double(credit1.text!)! * value[a]
                        temp2 = Double(credit2.text!)! * value[b]
                        temp = (temp1 + temp2)/sum
                        stemp = String(format: "%.3f", temp)
                        if(stemp < cgpa)
                        {
                            b = 12
                        }
                        if (stemp == cgpa)
                        {
                            str = grade[a] + " " + grade[b]
                            final.append(str)
                            w = true
                        }
                    }
                }
            }
            else if(credit3.text != "" && credit4.text == "")
            {
                sum = Double(credit1.text!)! + Double(credit2.text!)! + Double(credit3.text!)!
                for var a = 0; a < 12; ++a
                {
                    for var b = 0; b < 12; ++b
                    {
                        for var c = 0; c < 12; ++c
                        {
                            temp1 = Double(credit1.text!)! * value[a]
                            temp2 = Double(credit2.text!)! * value[b]
                            temp3 = Double(credit3.text!)! * value[c]
                            temp = (temp1 + temp2 + temp3)/sum
                            stemp = String(format: "%.3f", temp)
                            if(stemp < cgpa)
                            {
                                c = 12
                            }
                            if (stemp == cgpa)
                            {
                                str = grade[a] + " " + grade[b] + " " + grade[c]
                                final.append(str)
                                w = true
                            }
                        }
                    }
                }
                
            }
            else if(credit4.text != "" && credit5.text == "")
            {
                sum = Double(credit1.text!)! + Double(credit2.text!)! + Double(credit3.text!)! + Double(credit4.text!)!
                for var a = 0; a < 12; ++a
                {
                    for var b = 0; b < 12; ++b
                    {
                        for var c = 0; c < 12; ++c
                        {
                            for var d = 0; d < 12; ++d
                            {
                                temp1 = Double(credit1.text!)! * value[a]
                                temp2 = Double(credit2.text!)! * value[b]
                                temp3 = Double(credit3.text!)! * value[c]
                                temp4 = Double(credit4.text!)! * value[d]
                                temp = (temp1 + temp2 + temp3 + temp4)/sum
                                stemp = String(format: "%.3f", temp)
                                if(stemp < cgpa)
                                {
                                    d = 12
                                }
                                if (stemp == cgpa)
                                {
                                    str = grade[a] + " " + grade[b] + " " + grade[c] + " " + grade[d]
                                    final.append(str)
                                    w = true
                                }
                            }
                        }
                    }
                }
            }
            else if(credit5.text != "" && credit6.text == "")
            {
                sum = Double(credit1.text!)! + Double(credit2.text!)! + Double(credit3.text!)! + Double(credit4.text!)! + Double(credit5.text!)!
                for var a = 0; a < 12; ++a
                {
                    for var b = 0; b < 12; ++b
                    {
                        for var c = 0; c < 12; ++c
                        {
                            for var d = 0; d < 12; ++d
                            {
                                for var e = 0; e < 12; ++e
                                {
                                    temp1 = Double(credit1.text!)! * value[a]
                                    temp2 = Double(credit2.text!)! * value[b]
                                    temp3 = Double(credit3.text!)! * value[c]
                                    temp4 = Double(credit4.text!)! * value[d]
                                    temp5 = Double(credit5.text!)! * value[e]
                                    temp = (temp1 + temp2 + temp3 + temp4 + temp5)/sum
                                    stemp = String(format: "%.3f", temp)
                                    if(stemp < cgpa)
                                    {
                                        e = 12
                                    }
                                    if (stemp == cgpa)
                                    {
                                        str = grade[a] + " " + grade[b] + " " + grade[c] + " " + grade[d] + " " + grade[e]
                                        final.append(str)
                                        w = true
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
            else if(credit6.text != "")
            {
                sum = Double(credit1.text!)! + Double(credit2.text!)! + Double(credit3.text!)! + Double(credit4.text!)! + Double(credit5.text!)! + Double(credit6.text!)!
                for var a = 0; a < 12; ++a
                {
                    for var b = 0; b < 12; ++b
                    {
                        for var c = 0; c < 12; ++c
                        {
                            for var d = 0; d < 12; ++d
                            {
                                for var e = 0; e < 12; ++e
                                {
                                    for var f = 0; f < 12; ++f
                                    {
                                        temp1 = Double(credit1.text!)! * value[a]
                                        temp2 = Double(credit2.text!)! * value[b]
                                        temp3 = Double(credit3.text!)! * value[c]
                                        temp4 = Double(credit4.text!)! * value[d]
                                        temp5 = Double(credit5.text!)! * value[e]
                                        temp6 = Double(credit6.text!)! * value[f]
                                        temp = (temp1 + temp2 + temp3 + temp4 + temp5 + temp6)/sum
                                        stemp = String(format: "%.3f", temp)
                                        if(stemp < cgpa)
                                        {
                                            f = 12
                                        }
                                        if (stemp == cgpa)
                                        {
                                            str = grade[a] + " " + grade[b] + " " + grade[c] + " " + grade[d] + " " + grade[e] + " " + grade[f]
                                            final.append(str)
                                            w = true
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                msgText.text =  "Please enter the correct way"
            }
            if(w == false)
            {
                ++i
                
                var y = Double(cgpa)
                y = y! - 0.010
                cgpa = String(format: "%.3f", y!)
                var p = "Could not find GPA trying " + cgpa
                msgText.text = p
            }
        }
        
        tableView.reloadData()
        
    }
    
    
}

