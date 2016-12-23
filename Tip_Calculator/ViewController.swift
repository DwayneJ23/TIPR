//
//  ViewController.swift
//  Tip_Calculator
//
//  Created by Dwayne Johnson on 12/13/16.
//  Copyright (c) 2016 Dwayne Johnson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var numberOfPeopleField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!   // Global variable to update tip UIlabel dynamically
    @IBOutlet weak var totalLabel: UILabel!   // Global variable to update total UIlabel dynamically
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!  // Controls tip value
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        billField.text = ""
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        numberOfPeopleField.text = "1"
        totalPerPersonLabel.text = "$0.00"
        
        // Load default tip percentage from SettingsViewController
        // with associated key "default_tip_percentage"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipValue = defaults.integerForKey("default_tip_percentage")
        tipControl.selectedSegmentIndex = tipValue
        
        // Load data from previous session if the time from last use
        // is less than 10 mins, otherwise start fresh

        let previousTime: NSDate! = defaults.objectForKey("previousTime") as NSDate
        let elapasedTime = NSDate().timeIntervalSinceDate(previousTime)
        if (elapasedTime < 600)
        {
            // Load saved bill, tip, and number of people fields
                
            let savedBill = defaults.stringForKey("savedBillField")
            billField.text = savedBill
            
            let savedTipValue = defaults.integerForKey("savedTip")
            tipControl.selectedSegmentIndex = savedTipValue
            
            let savedPeople = defaults.stringForKey("savedNumberOfPeopleField")
            numberOfPeopleField.text = savedPeople
            
        }
        
        // Save current time
        let currentTime: NSDate! = NSDate()
        defaults.setObject(currentTime, forKey: "previousTime")
        defaults.synchronize()
        
        // The bill amount is always the first responder. This way 
        // the user doesn't have to tap anywhere to use this app.
        // Just launch the app and start typing.
        
        billField.becomeFirstResponder()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // print("view will appear")
        
        // This is a good place to retrieve the default tip percentage from NSUserDefaults
        // and use it to update the tip amount
        
        // Load default tip percentage from SettingsViewController
        // with associated key "default_tip_percentage"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipValue = defaults.integerForKey("default_tip_percentage")
        tipControl.selectedSegmentIndex = tipValue
        
        // Create function to update totals after default tip has been changed
        
        updateFields()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func hideKeyboard(sender: AnyObject) {
        view.endEditing(true)
    }

    @IBAction func calculateTip(sender: AnyObject) {
        
        updateFields()
        
        // Save bill, tip, and number of people fields
        let index = tipControl.selectedSegmentIndex
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billField.text, forKey: "savedBillField")
        defaults.setInteger(index, forKey: "savedTip")
        defaults.setObject(numberOfPeopleField.text, forKey: "savedNumberOfPeopleField")
        defaults.synchronize()

    }
    
    @IBAction func clear(sender: AnyObject) {
        
        billField.text = ""
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        numberOfPeopleField.text = "1"
        totalPerPersonLabel.text = "$0.00"
        
        // Save bill, tip, and number of people fields
        let index = tipControl.selectedSegmentIndex
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billField.text, forKey: "savedBillField")
        defaults.setInteger(index, forKey: "savedTip")
        defaults.setObject(numberOfPeopleField.text, forKey: "savedNumberOfPeopleField")
        defaults.synchronize()
        
    }
    
    func updateFields(){
        
        let tipPercentages = [0.05, 0.10, 0.15, 0.20]
        let bill = NSString(string: billField.text).doubleValue // String to double conversion
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex] // Calculate tip amount
        let total = bill + tip // Calculate bill total with tip included
        let people = NSString(string: numberOfPeopleField.text).doubleValue // String to double conversion
        let costPerPerson = total / Double(people)  // Calcualate cost per person
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        if(Double(people) == 0 ){
            totalPerPersonLabel.text = "$0.00"
        }
        else {
            totalPerPersonLabel.text = String(format: "$%.2f", costPerPerson)
        }

    }
    
}

