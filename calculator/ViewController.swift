//
//  ViewController.swift
//  calculator
//
//  Created by Sid on 22/01/2018.
//  Copyright © 2018 Siddhant Bhatia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userInputDisplay: UILabel!
    @IBOutlet weak var resultDisplay: UILabel!
    
    var numberInputString : String = ""
    var equationDisplayString : String = ""
    
    var firstNumber : Float = 0
    var secondNumber : Float = 0
    
    var operationType : Int = 0
    var decimalButtonPressed : Bool = false
    var equalButtonPressed : Bool = false
    var divideByZero : Bool = false
    
    var result : Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        resultDisplay.text = String(0)
        userInputDisplay.text = String(0)
    }
    
//    var firstNumberEntry : Bool = false
//    var secondNumberEntry : Bool = false
    
    
    @IBAction func numberButtonPressed(_ sender: UIButton)
    {
        /* to check if decimal button is pressed
         * decimal button tag is 10
         * if pressed, lock it from taking input
         */
        if decimalButtonPressed == false && sender.tag == 10
        {
            decimalButtonPressed = true
            numberInputString = numberInputString + "."
            equationDisplayString = equationDisplayString + "."
        }
        
        if sender.tag != 10
        {
            numberInputString = numberInputString + String(sender.tag)
            equationDisplayString = equationDisplayString + String(sender.tag)
        }
        
        updateUI(withNumberData: numberInputString, withEquationData: equationDisplayString)
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton)
    {
        numberInputString = ""
        equationDisplayString = ""
        
        updateUI(withNumberData: "0", withEquationData: "0")
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton)
    {
        firstNumber = Float(numberInputString)!
        
        operationType = sender.tag
        
        switch(operationType)
        {
        case 1:
            equationDisplayString = equationDisplayString + "+"
            
        case 2:
            equationDisplayString = equationDisplayString + "-"
        case 3:
            equationDisplayString = equationDisplayString + "x"
            
        default:
            equationDisplayString = equationDisplayString + "/"
        }

        decimalButtonPressed = false
        
        updateUI(withNumberData: numberInputString, withEquationData: equationDisplayString)
        
        numberInputString = ""
    }
    
    
    @IBAction func equalButtonPressed(_ sender: UIButton)
    {
        secondNumber = Float(numberInputString)!
        
        switch(operationType)
        {
        case 1:
            result = firstNumber + secondNumber
        
        case 2:
            result = firstNumber - secondNumber
        
        case 3:
            result = firstNumber * secondNumber
        
        default:
            if secondNumber != 0
            {
                result = firstNumber / secondNumber
            }
            else
            {
                divideByZero = true
            }
        }
        
        if divideByZero
        {
            updateUI(withNumberData: "Error", withEquationData: equationDisplayString)
            
        }
        else{
            updateUI(withNumberData: String(result), withEquationData: equationDisplayString)
        }
        
        divideByZero = false
        
        numberInputString = ""
        equationDisplayString = ""
        
    }
    
    func updateUI(withNumberData number : String, withEquationData equation: String)
    {
        //to remove the trailing .0 so that only integer appears
        if number.suffix(2) == ".0"
        {
            resultDisplay.text = String(number.dropLast(2))
        }
        else{
            resultDisplay.text = number
        }
        
        userInputDisplay.text = equation
    }
    
    
}

