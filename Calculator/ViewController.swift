//
//  ViewController.swift
//  Calculator
//
//  Created by Jonathan Zelaya on 8/9/16.
//  Copyright © 2016 Jonathan Zelaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet fileprivate weak var display: UILabel!
    fileprivate var userIsInTheMiddleOfTyping = false
    @IBOutlet weak var radDeg: UILabel!
    
    @IBAction fileprivate func touchDigit(_ sender: UIButton){
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping{
            display.text = display.text! + digit
        }else {
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true;
    }
    
    fileprivate var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            if round(newValue) == newValue{
                let myString = String(newValue)
                display.text = myString.substring(with: Range<String.Index>(myString.startIndex ..< myString.characters.index(myString.endIndex, offsetBy: -2)))
            }else{
                display.text = String(newValue)
            }
        }
    }
    

    
    fileprivate var brain = CalculatorBrain()
    
    @IBAction fileprivate func performOperation(_ sender: UIButton) {
        // if user was typing a number and clicks operator then save operand
        if userIsInTheMiddleOfTyping{
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
        }
        
        // if button has a value, then let the model perform the operation, sending
        // the symbol as an argument
        if let mathematicalSymbol = sender.currentTitle{
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
    
    @IBAction fileprivate func makeDecimal() {
        if(!(display.text?.contains("."))!){
            display.text = display.text! + "."
        }
    }
    
    fileprivate var angleMode = "Rad"
    
    @IBAction fileprivate func switchAngle(_ sender: UIButton) {
        let type = sender.currentTitle
        // if the button says Deg then change it to radian but go in deg mode
        if type == "Deg"{
            sender.setTitle("Rad", for: UIControlState())
            angleMode = "Deg"
            radDeg.text = "Deg"
        }else{
            sender.setTitle("Deg", for: UIControlState())
            angleMode = "Rad"
            radDeg.text = "Rad"
        }
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
}
