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
        }
        else {
            // Hide and diable the cancel button
            self.cancel.hidden = true
            self.cancel.enabled = false
        }
        var gPickerView1 = UIPickerView()
        var gPickerView2 = UIPickerView()
        var gPickerView3 = UIPickerView()
        var gPickerView4 = UIPickerView()
        var gPickerView5 = UIPickerView()
        var gPickerView6 = UIPickerView()
        var cPickerView1 = UIPickerView()
        var cPickerView2 = UIPickerView()
        var cPickerView3 = UIPickerView()
        var cPickerView4 = UIPickerView()
        var cPickerView5 = UIPickerView()
        var cPickerView6 = UIPickerView()
        
        gPickerView1.delegate = self
        gPickerView2.delegate = self
        gPickerView3.delegate = self
        gPickerView4.delegate = self
        gPickerView5.delegate = self
        gPickerView6.delegate = self
        cPickerView1.delegate = self
        cPickerView2.delegate = self
        cPickerView3.delegate = self
        cPickerView4.delegate = self
        cPickerView5.delegate = self
        cPickerView6.delegate = self
        
        grade1.inputView = gPickerView1
        grade2.inputView = gPickerView2
        grade3.inputView = gPickerView3
        grade4.inputView = gPickerView4
        grade5.inputView = gPickerView5
        grade6.inputView = gPickerView6
        credit1.inputView = cPickerView1
        credit2.inputView = cPickerView2
        credit3.inputView = cPickerView3
        credit4.inputView = cPickerView4
        credit5.inputView = cPickerView5
        credit6.inputView = cPickerView6
        
        gPickerView1.tag = 0
        gPickerView2.tag = 1
        gPickerView3.tag = 2
        gPickerView4.tag = 3
        gPickerView5.tag = 4
        gPickerView6.tag = 5
        cPickerView1.tag = 6
        cPickerView2.tag = 7
        cPickerView3.tag = 8
        cPickerView4.tag = 9
        cPickerView5.tag = 10
        cPickerView6.tag = 11
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return pickGrade.count
        }
        else if pickerView.tag == 1 {
            return pickGrade.count
        }
        else if pickerView.tag == 2 {
            return pickGrade.count
        }
        else if pickerView.tag == 3 {
            return pickGrade.count
        }
        else if pickerView.tag == 4 {
            return pickGrade.count
        }
        else if pickerView.tag == 5 {
            return pickGrade.count
        }
        else if pickerView.tag == 6 {
            return pickCredit.count
        }
        else if pickerView.tag == 7 {
            return pickCredit.count
        }
        else if pickerView.tag == 8 {
            return pickCredit.count
        }
        else if pickerView.tag == 9 {
            return pickCredit.count
        }
        else if pickerView.tag == 10 {
            return pickCredit.count
        }
        else if pickerView.tag == 11 {
            return pickCredit.count
        }
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return pickGrade[row]
        }
        else if pickerView.tag == 1 {
            return pickGrade[row]
        }
        else if pickerView.tag == 2 {
            return pickGrade[row]
        }
        else if pickerView.tag == 3 {
            return pickGrade[row]
        }
        else if pickerView.tag == 4 {
            return pickGrade[row]
        }
        else if pickerView.tag == 5 {
            return pickGrade[row]
        }
        else if pickerView.tag == 6 {
            return pickCredit[row]
        }
        else if pickerView.tag == 7 {
            return pickCredit[row]
        }
        else if pickerView.tag == 8 {
            return pickCredit[row]
        }
        else if pickerView.tag == 9 {
            return pickCredit[row]
        }
        else if pickerView.tag == 10 {
            return pickCredit[row]
        }
        else if pickerView.tag == 11 {
            return pickCredit[row]
        }
        return ""
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0 {
            grade1.text = pickGrade[row]
        }
        else if pickerView.tag == 1 {
            grade2.text = pickGrade[row]
        }
        else if pickerView.tag == 2 {
            grade3.text = pickGrade[row]
        }
        else if pickerView.tag == 3 {
            grade4.text = pickGrade[row]
        }
        else if pickerView.tag == 4 {
            grade5.text = pickGrade[row]
        }
        else if pickerView.tag == 5 {
            grade6.text = pickGrade[row]
        }
        else if pickerView.tag == 6 {
            credit1.text = pickCredit[row]
        }
        else if pickerView.tag == 7 {
            credit2.text = pickCredit[row]
        }
        else if pickerView.tag == 8 {
            credit3.text = pickCredit[row]
        }
        else if pickerView.tag == 9 {
            credit4.text = pickCredit[row]
        }
        else if pickerView.tag == 10 {
            credit5.text = pickCredit[row]
        }
        else if pickerView.tag == 11 {
            credit6.text = pickCredit[row]
        }
        self.view.endEditing(true)
    }
    
    @IBAction func calculateGPA(sender: AnyObject) {
        var value: [Double] = [4.00, 3.67, 3.33, 3.00, 2.67, 2.33, 2.00, 1.67, 1.33, 1.00, 0.67, 0]
        if ((grade1.text == "" && credit1.text != "") || (credit1.text == "" && grade1.text != "")) {
            gpaMsg.text = "Please ensure that adjacent fields are filled out, or are both blank!"
        }
        else if ((grade2.text == "" && credit2.text != "") || (credit2.text == "" && grade2.text != "")) {
            gpaMsg.text = "Please ensure that adjacent fields are filled out, or are both blank!"
        }
        else if ((grade3.text == "" && credit3.text != "") || (credit3.text == "" && grade3.text != "")) {
            gpaMsg.text = "Please ensure that adjacent fields are filled out, or are both blank!"
        }
        else if ((grade4.text == "" && credit4.text != "") || (credit4.text == "" && grade4.text != "")) {
            gpaMsg.text = "Please ensure that adjacent fields are filled out, or are both blank!"
        }
        else if ((grade5.text == "" && credit5.text != "") || (credit5.text == "" && grade5.text != "")) {
            gpaMsg.text = "Please ensure that adjacent fields are filled out, or are both blank!"
        }
        else if ((grade6.text == "" && credit6.text != "") || (credit6.text == "" && grade6.text != "")) {
            gpaMsg.text = "Please ensure that adjacent fields are filled out, or are both blank!"
        }
        else {
            gpaMsg.text = "0.0"
            var gr1 = 0.00
            var gr2 = 0.00
            var gr3 = 0.00
            var gr4 = 0.00
            var gr5 = 0.00
            var gr6 = 0.00
            
            var cr1 = 0.00
            var cr2 = 0.00
            var cr3 = 0.00
            var cr4 = 0.00
            var cr5 = 0.00
            var cr6 = 0.00
            var sum = 0.00
            
            var tot1 = 0.00
            var tot2 = 0.00
            var tot3 = 0.00
            var tot4 = 0.00
            var tot5 = 0.00
            var tot6 = 0.00
            
            var gpa = 0.00


            if(grade1.text != "")
            {
                for var a = 0; a < 12; a++
                {
                    if(grade1.text == pickGrade[a])
                    {
                        gr1 = value[a]
                    }
                }
                 cr1 = Double(credit1.text!)!
                tot1 = gr1 * cr1
            }
            
            if(grade2.text != "")
            {
                for var a = 0; a < 12; a++
                {
                    if(grade2.text == pickGrade[a])
                    {
                        gr2 = value[a]
                    }
                }
                 cr2 = Double(credit2.text!)!
                tot2 = gr2 * cr2
            }
            
            if(grade3.text != "")
            {
                for var a = 0; a < 12; a++
                {
                    if(grade3.text == pickGrade[a])
                    {
                        gr3 = value[a]
                    }
                }
                 cr3 = Double(credit3.text!)!
                tot3 = gr3 * cr3
            }
            
            if(grade4.text != "")
            {
                for var a = 0; a < 12; a++
                {
                    if(grade4.text == pickGrade[a])
                    {
                        gr4 = value[a]
                    }
                }
                 cr4 = Double(credit4.text!)!
                tot4 = gr4 * cr4
            }
            
            if(grade5.text != "")
            {
                for var a = 0; a < 12; a++
                {
                    if(grade5.text == pickGrade[a])
                    {
                        gr5 = value[a]
                    }
                }
                cr5 = Double(credit5.text!)!
                tot5 = gr5 * cr5
            }
            
            if(grade6.text != "")
            {
                for var a = 0; a < 12; a++
                {
                    if(grade6.text == pickGrade[a])
                    {
                        gr6 = value[a]
                    }
                }
                 cr6 = Double(credit6.text!)!
                tot6 = gr6 * cr6
            }
            
            sum = cr1 + cr2 + cr3 + cr4 + cr5 + cr6
            gpa = (tot1 + tot2 + tot3 + tot4 + tot5 + tot6) / sum
            
            gpaMsg.text = String(format: "%.3f", gpa)
            
        }
    }
    
    
    
    // Initialize Menu button
    func initMenuButton() {
        // Menu.target = self.revealViewController()
        Menu.action = Selector("revealToggle:")
        // self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    
}
