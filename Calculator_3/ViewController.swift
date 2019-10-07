//
//  ViewController.swift
//  Calculator_3
//
//  Created by Aleksey3a on 06.05.19.
//  Copyright © 2019 Antokhin Aleksey. All rights reserved.


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayResultLabel: UILabel!
    var stillTyping = false // сейчас будет вводиться новое число
    var dotIsPlased = false // для выделения дробной части
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = "" // знак действия

    var currentInput: Double {
        get {
            return Double(displayResultLabel.text!)!
        }
        
        set {
            let value = "\(newValue)" // ложим новое значение в строковую константу
            let valueArray = value.components(separatedBy: ".") // помещаем строку в массив разделив элементы символом "." 
            if valueArray[1] == "0" { // если правая часть массива(числа) т.е.  его 1-й элемент  = 0
                displayResultLabel.text = "\(valueArray[0])" // отображаем на дисплее 0-й эл массива т.е. левую часть числа до разделителя "."
            } else { // иначе если после "." дробная часть не равна 0, например: 25.45345
                displayResultLabel.text = "\(newValue)" // отображаем новое дробное число без изменений т.е. как есть не из массива
            }
            stillTyping = false // вводим новое число
        }
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        
        let number = sender.currentTitle!

        if stillTyping {
            if (displayResultLabel.text?.count)! < 20 {
                displayResultLabel.text = displayResultLabel.text! + number
            }
        } else {
            displayResultLabel.text = number
            stillTyping = true
        }
        
        
    }
    
    @IBAction func twoOperandsSignPressed(_ sender: UIButton) { // нажимаем на кнопку действий
        operationSign = sender.currentTitle! // получаем заголовок кнопки
        firstOperand = currentInput // ложим текущее число в "firstOperand"
        stillTyping = false 
        dotIsPlased = false // у следующего числа точка пока не стоит
    }
    
    func operateWithOperands (operation: (Double, Double) -> Double) { // принимаем во входящем аргументе клоужер
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false // после нажатия на "=" цыфры не добавляются на дисплей
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput // сохраняем второй операнд
        }
        
        dotIsPlased = false // при следующем вводе нового числа дробная часть не выделяется
        
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
    @IBAction func clearButtonPressed(_ sender: UIButton) { // после нажатия на "C" можем начать все вичисления заново
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLabel.text = "0"
        stillTyping = false
        dotIsPlased = false
        operationSign = ""
        
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) { //  меняет значение на дисплее на противоположный знак
        currentInput = -currentInput
    }
    
    @IBAction func persentageButtonPressed(_ sender: UIButton) { // вычисляем проценты
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
    }
    
    @IBAction func squareRootButtonPressed(_ sender: UIButton) { // вычисляем квадратный корень
        currentInput = sqrt(currentInput)
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) { // выделяем дробную часть
        if stillTyping && !dotIsPlased { // если можно писать и точка еще не стоит
            displayResultLabel.text = displayResultLabel.text! + "."
            dotIsPlased = true
            
        } else if !stillTyping && !dotIsPlased { // если нельзя печатать и точка не стоит
            displayResultLabel.text = "0."
        }
    }
}
    


