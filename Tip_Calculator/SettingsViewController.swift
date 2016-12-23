//
//  SettingViewController.swift
//  Tip_Calculator
//
//  Created by Dwayne Johnson on 12/13/16.
//  Copyright (c) 2016 Dwayne Johnson. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    @IBOutlet weak var currentDefaultLabel: UILabel!
    @IBOutlet weak var defaultTitleLabel: UILabel!
    @IBOutlet weak var defaultButton: UIButton!
    @IBOutlet weak var currentTitleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Load default tip value
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipValue = defaults.integerForKey("default_tip_percentage")
        defaultTipControl.selectedSegmentIndex = tipValue
        
        // Update current default tip label
        currentDefaultLabel.text = defaultTipControl.titleForSegmentAtIndex(tipValue)
        
//        defaultTitleLabel.alpha = 0.0
//        defaultTipControl.alpha = 0.0
//        defaultButton.alpha = 0.0
//        currentTitleLabel.alpha = 0.0
//        currentDefaultLabel.alpha = 0.0
//        
//        UIView.animateWithDuration(2.0, animations: {
//            self.defaultTitleLabel.alpha = 1.0
//            self.defaultTipControl.alpha = 1.0
//            self.defaultButton.alpha = 1.0
//            self.currentTitleLabel.alpha = 1.0
//            self.currentDefaultLabel.alpha = 1.0
//        })
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        defaultTitleLabel.alpha = 0.0
        defaultTipControl.alpha = 0.0
        defaultButton.alpha = 0.0
        currentTitleLabel.alpha = 0.0
        currentDefaultLabel.alpha = 0.0
        
        UIView.animateWithDuration(2.0,
            animations: {
            self.defaultTitleLabel.alpha = 1.0
            self.defaultTipControl.alpha = 1.0
            self.defaultButton.alpha = 1.0
            self.currentTitleLabel.alpha = 1.0
            self.currentDefaultLabel.alpha = 1.0
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setDefaultTip(sender: AnyObject) {
        
        let index = defaultTipControl.selectedSegmentIndex
        
        // Save default tip
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(index, forKey: "default_tip_percentage")
        defaults.synchronize()
    
        // Alert message - tip saved conformation
        var alert = UIAlertController(title: "Saved", message: "Default tip has been saved", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
            
        // Update current default tip label
        currentDefaultLabel.text = defaultTipControl.titleForSegmentAtIndex(index)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
