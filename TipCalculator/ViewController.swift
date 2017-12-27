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
    @IBOutlet var payAmount: UILabel!
    var splitCount: Double = 1
    let defaults = UserDefaults.standard
    
    //text labels with no functionality
    @IBOutlet var splitText: UILabel!
    @IBOutlet var payText: UILabel!
    @IBOutlet var totalText: UILabel!
    @IBOutlet var tipText: UILabel!
    
    
    //////////////////////////////
          //picker view stuff
    //////////////////////////////
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
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        if(defaults.bool(forKey: "lightMode")) {
            let titleData = split[row]
            let myTitle = NSAttributedString(
                string: titleData,
                attributes: [
                    NSAttributedStringKey.font:UIFont(name: "Georgia", size: 15.0)!,
                    NSAttributedStringKey.foregroundColor:UIColor.black
                ])
            return myTitle
        }
        else {
            let titleData = split[row]
            let myTitle = NSAttributedString(
                string: titleData,
                attributes: [
                    NSAttributedStringKey.font:UIFont(name: "Georgia", size: 15.0)!,
                    NSAttributedStringKey.foregroundColor:UIColor.white
                ])
            return myTitle
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        calculateTip(self)
    }
    
    /*////////////////////////////
            loading stuff
    //////////////////////////// */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerView.delegate = self
        pickerView.dataSource = self
        billLabel.becomeFirstResponder()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        pickerView.delegate = self
        pickerView.dataSource = self
        if(defaults.bool(forKey: "lightMode")) {
            self.view.backgroundColor = UIColor.white
            tipLabel.textColor = UIColor.black
            totalLabel.textColor = UIColor.black
            billLabel.textColor = UIColor.black
            pickerView.backgroundColor = UIColor.white
            payAmount.textColor = UIColor.black
            splitText.textColor = UIColor.black
            payText.textColor = UIColor.black
            totalText.textColor = UIColor.black
            tipText.textColor = UIColor.black
        }
        else {
            self.view.backgroundColor = UIColor.black
            tipLabel.textColor = UIColor.white
            totalLabel.textColor = UIColor.white
            billLabel.textColor = UIColor.white
            pickerView.backgroundColor = UIColor.black
            payAmount.textColor = UIColor.white
            splitText.textColor = UIColor.white
            payText.textColor = UIColor.white
            totalText.textColor = UIColor.white
            tipText.textColor = UIColor.white
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true);
    }
    
    //////////////////////////////
         //buisness logic stuff
    //////////////////////////////
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

        let selectedValue = split[pickerView.selectedRow(inComponent: 0)]
        
        splitCount = Double(selectedValue)!
        
        let splitTotal = (bill + tip) / splitCount
        
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        payAmount.text = String(format: "$%.2f", splitTotal)
        
    }
}

