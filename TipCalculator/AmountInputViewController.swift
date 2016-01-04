//
//  AmountInputViewController.swift
//  TipCalculator
//
//  Created by Maury Alamin on 11/3/15.
//  Copyright © 2015 Alamin. All rights reserved.
//

import UIKit

class AmountInputViewController: UIViewController {
    
    @IBOutlet weak var checkAmountField: UITextField!
    @IBOutlet weak var tipAmountField: UILabel!
    @IBOutlet weak var totalBillTitleLabel: UILabel!
    @IBOutlet weak var totalBillLabel: UILabel!
    
    // Tip Rate Buttons
    @IBOutlet weak var tip10: UIButton!
    @IBOutlet weak var tip15: UIButton!
    @IBOutlet weak var tip20: UIButton!
    @IBOutlet weak var tipOther: UIButton!
    
    // Properties
    var tipRate : Double = 0.15
    // Set locale
    let unitedStatesLocale = NSLocale(localeIdentifier: "en_US")
    // Create number formatter
    var currencyFormatter = NSNumberFormatter()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Dollar Conversion
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = unitedStatesLocale
        
        // Highlight default button
        tip15.selected = true
        
        totalBillLabel.hidden = true
        totalBillTitleLabel.hidden = true
        
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func processBill(sender: UIButton) {
        
        print("there is nothing in field")
        
        calculateTip(tipRate)
        
        dismissKeyboard()
    }
    
    func calculateTip(rate:Double) {
        
        if checkAmountField.text == "" {
            checkAmountField.text = "0.00"
        }
        
        let checkAmount:Double = Double(checkAmountField.text!)!
        
        let tip = checkAmount * tipRate
        let totalBill = checkAmount + tip
        
        let fullDollarTipFormat = currencyFormatter.stringFromNumber(tip)!
        let slicedDollarTipFormat = String(fullDollarTipFormat.characters.dropFirst())
        
        tipAmountField.text = slicedDollarTipFormat
        totalBillLabel.text = currencyFormatter.stringFromNumber(totalBill)!
        
        totalBillLabel.hidden = false
        totalBillTitleLabel.hidden = false
    }
    
    @IBAction func tipPercentage(sender: UIButton) {
        
        let buttonTitle = sender.titleLabel?.text
        
        print("\(buttonTitle!)")
        
        switch buttonTitle! {
            
        case "10%":
            tipRate = 0.10
            tipButtonState(tip10)
            calculateTip(tipRate)
            
        case "15%":
            tipRate = 0.15
            tipButtonState(tip15)
            calculateTip(tipRate)
            
        case "20%":
            tipRate = 0.20
            tipButtonState(tip20)
            calculateTip(tipRate)

        default:
            tipButtonState(tipOther)
            newTipRate()
            
        }
        
        dismissKeyboard()
        
    }
    
    func tipButtonState(button:UIButton) {
        
        tip10.selected = false
        tip15.selected = false
        tip20.selected = false
        tipOther.selected = false
        
        button.selected = true
    }
    
    // Dismiss Keyboard
    //Calls this function when the tap is recognized.
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func newTipRate() {
        
        // New AlertController
        let customRate = UIAlertController(title: "Tip Rate", message: "Enter a new tip percentage.", preferredStyle: .Alert)
        
        // Add textfield to AlertController
        customRate.addTextFieldWithConfigurationHandler {
            (tf:UITextField) in
            tf.keyboardType = .NumberPad
        }
        
        func handler (act:UIAlertAction) {
            // Get text from field
            let tf = customRate.textFields![0]
            
            // Create percentage string object
            let newRateString = "0.\(tf.text!)"
            
            // Convert percentage string to Double and set new tipRate
            tipRate = Double(newRateString)!
            
            // Set new title for button
            tipOther.setTitle("\(tf.text!)%", forState: .Selected)
            tipOther.setTitle("\(tf.text!)%", forState: .Normal)
            
            calculateTip(tipRate)
            
        }
        // Add action buttons to AlertController
        customRate.addAction(UIAlertAction (title: "Cancel", style: .Cancel, handler: nil))
        customRate.addAction(UIAlertAction(title: "OK", style: .Default, handler: handler))
        
        // Show AlertController
        presentViewController(customRate, animated: true, completion: nil)
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
