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
    var secondOperand: Double = 0
    var operationSign: String = "" // знак действия

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
        operationSign = sender.currentTitle! // получаем заголовок кнопки
        firstOperand = currentInput
        stillTyping = false
    }
    
    func operateWithOperands (operation: (Double, Double) -> Double) { // принимаем во входящем аргументе клоужер
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false // после нажатия на "=" цыфры не добавляются на дисплей
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        switch operationSign {
            case "+":
                operateWithOperands{$0 + $1} // вызов функции-замыкания принимающая два аргумента и выполняющая действие
            case "-":
                operateWithOperands{$0 - $1}
            case "✕":
                operateWithOperands{$0 * $1}
            case "÷":
                operateWithOperands{$0 / $1}
        default: break
         }
        
        }
    }
    


