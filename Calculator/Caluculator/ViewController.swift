//
//  ViewController.swift
//  Caluculator
//
//  Created by Chava, Sravya on 11/20/18.
//  Copyright © 2018 Chava, Sravya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var numberOnScreen: Double = 0;
    var previousNumber: Double = 0;
    var performMath = true;
    var operation: Int = 0
    @IBOutlet weak var label: UILabel!
    @IBAction func numbers(_ sender: UIButton) {
        if performMath == true{
            if sender.tag == 19
            {
            label.text = "."
            numberOnScreen = Double(label.text!)!
            performMath = false
            }
            else
            {
            label.text = String(sender.tag-1)
            numberOnScreen = Double(label.text!)!
            performMath = false
            }
        }
        else
        {
            label.text = label.text! + String(sender.tag-1)
            print (label.text as Any)
            numberOnScreen = Double(label.text!)!
        }
    }
    @IBAction func buttons(_ sender: UIButton) {
        if label.text != "" && sender.tag != 11 && sender.tag != 16
        {
            previousNumber = Double(label.text!)!
            if sender.tag == 12
            {
               label.text = "/"
            }
            else if sender.tag == 13
            {
                label.text = "X"
            }
            else if sender.tag == 14
            {
                label.text = "-"
            }
            else if sender.tag == 15
            {
                    label.text = "+"
            }
            else if sender.tag == 17
            {
                label.text = "+/-"
            }
            else if sender.tag == 18
            {
                label.text = "%"
            }
            operation = sender.tag
            performMath = true
        }
        else if sender.tag == 16
        {
            if operation == 12
            {
                label.text = String(previousNumber / numberOnScreen)
            }
            else if operation == 13
            {
                label.text = String(previousNumber * numberOnScreen)
            }
            else if operation == 14
            {
                label.text = String(previousNumber - numberOnScreen)
            }
            else if operation == 15
            {
                label.text = String(previousNumber + numberOnScreen)
            }
            else if operation == 17
            {
                if previousNumber < 0
                {
                    label.text = "+" + String(previousNumber)
                }
                if previousNumber > 0
                {
                    label.text = "-" + String(previousNumber)
                }
            }
            else if operation == 18
            {
                label.text = String(previousNumber .truncatingRemainder(dividingBy: numberOnScreen))
            }
        }
        else if sender.tag == 11
        {
            label.text = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

