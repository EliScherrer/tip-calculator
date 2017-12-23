//
//  ViewController.swift
//  TipCalculator
//
//  Created by Eli Scherrer on 12/9/17.
//  Copyright © 2017 Eli Scherrer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet var tipLabel: UILabel!
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var billLabel: UITextField!
    @IBOutlet var tipControl: UISegmentedControl!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let split = ["1","2","3","4","5","6","7","8","9","10"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return split.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return split[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true);
    }
    
    @IBAction func addMoneyLabel(_ sender: Any) {
        let curText = billLabel.text
        let cropped = String(curText!.characters.filter { "01234567890.".characters.contains($0) })
        billLabel.text = "$" + cropped
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        
        let tipPercentages = [0.15, 0.2, 0.22]
        
        let cropped = String(billLabel.text!.characters.filter { "01234567890.".characters.contains($0) })
        
        let bill = Double(cropped) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
    }
}

