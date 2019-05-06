//
//  ViewController.swift
//  Calculator_3
//
//  Created by Aleksey3a on 06.05.19.
//  Copyright © 2019 Antokhin Aleksey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayResultLabel: UILabel!
    var stillTyping = false // сейчас будет вводиться новое число
    var firstOperand: Double = 0
    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        
        set {
            displayResultLabel.text = "\(newValue)"
            stillTyping = false // вводим новое число
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        let number = sender.currentTitle!

        if stillTyping {
            if (displayResultLabel.text?.characters.count)! < 20 {
                displayResultLabel.text = displayResultLabel.text! + number
            }
        } else {
            displayResultLabel.text = number
            stillTyping = true
        }
        
        
    }
    
    @IBAction func twoOperandsSignPressed(_ sender: UIButton) { // нажимаем на кнопку действий
        
        firstOperand = currentInput
        print(firstOperand)
        stillTyping = false
    }
}

