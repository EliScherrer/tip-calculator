//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Eli Scherrer on 12/24/17.
//  Copyright © 2017 Eli Scherrer. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var colorControl: UISegmentedControl!
    @IBOutlet var pageTitle: UILabel!
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(defaults.bool(forKey: "lightMode")) {
            self.view.backgroundColor = UIColor.white
            pageTitle.textColor = UIColor.black
        }
        else {
            self.view.backgroundColor = UIColor.black
            pageTitle.textColor = UIColor.white
            colorControl.selectedSegmentIndex = 1;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeColor(_ sender: Any) {
        //if light
        if (colorControl.selectedSegmentIndex == 0) {
            defaults.set(true, forKey: "lightMode")
            defaults.synchronize()
            self.view.backgroundColor = UIColor.white
            pageTitle.textColor = UIColor.black
        }
        //if dark
        else if (colorControl.selectedSegmentIndex == 1) {
            defaults.set(false, forKey: "lightMode")
            defaults.synchronize()
            self.view.backgroundColor = UIColor.black
            pageTitle.textColor = UIColor.white
        }
    
    }
    
    
    
//    let tipPercentages = [0.15, 0.2, 0.22]
//
//    let cropped = String(billLabel.text!.characters.filter { "01234567890.".characters.contains($0) })
//
//    let bill = Double(cropped) ?? 0
//    let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]

}
