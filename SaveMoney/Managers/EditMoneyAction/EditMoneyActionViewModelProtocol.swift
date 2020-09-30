//
//  EditMoneyActionViewModelProtocol.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 16.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation


protocol EditMoneyActionViewModelProtocol {
    var amountForShow: Box<String> { get }
    var currentAction: Box<CalculateActionWithOperate> { get }
    init(editMoneyAction: MoneyAction)
    func setName(name: String?)
    func setDate(date: Date)
    func setName(name: String)
    func getResult() -> AlertError
    func getDateForShow() -> String
    func getNavigationBarTitile() -> String
    func getName() -> String
    func getDate() -> Date
    func processActionWithNumber(action: CalculateActionWithNumber)
    func operateActionWitOperation(action: CalculateActionWithOperate) -> AlertError
    func acceptCloseKeyBoard() -> Bool
    func saveMoneyAction() -> AlertError
}

class EditMoneyActionViewModel: EditMoneyActionViewModelProtocol {
    
    
    var amountForShow: Box<String>
    var currentAction = Box<CalculateActionWithOperate>(value: .noAction)
       private var firstOperand: Double?
       private var name: String = ""
       private var date: Date
       private var isFractional = false
       private var editMoneyAction: MoneyAction
       private var isFirstOperation = true
    
    required init(editMoneyAction: MoneyAction) {
        self.editMoneyAction = editMoneyAction
        date = editMoneyAction.date
        name = editMoneyAction.name
        firstOperand = editMoneyAction.moneyCount
        amountForShow = Box<String>(value: editMoneyAction.moneyCount.toString())
    }
    
    func setName(name: String?) {
        self.name = name ?? ""
    }
    
    func setDate(date: Date) {
        self.date = date
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func getDateForShow() -> String {
         DateManager.shared.formatDateToString(date: date)
    }
    
    func getNavigationBarTitile() -> String {
        "Редактирование"
    }
    
    func getResult() -> AlertError {
        guard let secondNumber = Double(amountForShow.value) else { return AlertError(isError: true, message: "Введите корректное число")}
        guard let firstNumber = firstOperand else { return AlertError(isError: true, message: "Первое число введено некорректно. Нажмите AC") }
        var checkString = ""
        var checkNumber: Double?
        switch currentAction.value {
            
        case .doAddition:
            checkNumber = firstNumber + secondNumber
            checkString = (firstNumber + secondNumber).toString()
            
        case .doSubtraction:
            checkNumber = firstNumber - secondNumber
            checkString = (firstNumber - secondNumber).toString()
            
        case .doMultiplication:
            checkNumber = firstNumber * secondNumber
            checkString = (firstNumber * secondNumber).toString()
            
        case .doDivision:
            if secondNumber == 0 {
                checkNumber = nil
                checkString = ""
            } else {
                checkNumber = firstNumber / secondNumber
                checkString = (firstNumber / secondNumber).toString()
            }
            
        case .doPersent:
            checkNumber = firstNumber/100 * secondNumber
            checkString = (firstNumber/100 * secondNumber).toString()
            
        case .noAction:
            return  AlertError(isError: true, message: "Введена некорректная операция. Нажмите AC")
        case .deleteAction:
            return AlertError(isError: false)
        }
        
        if  checkString.count > 10 {
            return AlertError(isError: true, message: "Это число слишком большое")
            
        }
        
        amountForShow.value = checkString
        isFractional = amountForShow.value.contains(".")
        firstOperand = checkNumber
        currentAction.value = .noAction
        return AlertError(isError: false)
    }
    
    func getDate() -> Date {
        date
    }
    
    func getName() -> String {
        name
    }
    
    
    func processActionWithNumber(action: CalculateActionWithNumber) {
        if amountForShow.value.count > 10 && action != .delete {
            return
        }
        
        isFirstOperation = true
        switch action {
        case .writeNull:
            if amountForShow.value.count == 1 ,  amountForShow.value.first! == "0" {
                return
            }
            
            amountForShow.value.append("0")
            
        case .writeOne:
            if isZero() {
                amountForShow.value = "1"
                return
            }
            amountForShow.value.append("1")
            
        case .writeTwo:
            if isZero() {
                amountForShow.value = "2"
                return
            }
            amountForShow.value.append("2")
            
        case .writeThree:
            if isZero() {
                amountForShow.value = "3"
                return
            }
            amountForShow.value.append("3")
            
        case .writeFour:
            if isZero() {
                
                amountForShow.value = "4"
                return
            }
            amountForShow.value.append("4")
            
        case .writeFive:
            if isZero() {
                amountForShow.value = "5"
                return
            }
            amountForShow.value.append("5")
            
        case .writeSix:
            if isZero() {
                amountForShow.value = "6"
                return
                
            }
            amountForShow.value.append("6")
            
        case .writeSeven:
            if isZero() {
                amountForShow.value = "7"
                return
            } else {
                amountForShow.value.append("7")
            }
            
        case .writeEight:
            if isZero() {
                amountForShow.value = "8"
                return
            }
            amountForShow.value.append("8")
            
        case .writeNine:
            if isZero() {
                amountForShow.value = "9"
                return
            }
            amountForShow.value.append("9")
            
            
        case .delete:
            
            if !amountForShow.value.isEmpty ,amountForShow.value.removeLast() == "." {
                isFractional.toggle()
            }
            
        case .writePoint:
            if isFractional || amountForShow.value.count == 0 {
                return
            }
            amountForShow.value.append(".")
            isFractional.toggle()
        }
        
        firstOperand = Double(amountForShow.value)
        
    }
    
    func operateActionWitOperation(action: CalculateActionWithOperate) -> AlertError {
        if !isFirstOperation {
            currentAction.value = action
            return AlertError(isError: false)
        }
        guard let number = Double(amountForShow.value) else { return AlertError(isError: true, message: "Введите корректное число")  }
        firstOperand = number
        
        switch action {
            
        case .doAddition:
            currentAction.value = .doAddition
            
        case .doSubtraction:
            currentAction.value = .doSubtraction
            
        case .doMultiplication:
            currentAction.value = .doMultiplication
            
        case .doDivision:
            currentAction.value = .doDivision
            
        case .doPersent:
            currentAction.value  = .doPersent
            
        case .noAction:
            return  AlertError(isError: true, message: "Введена некорректная операция. Нажмите AC")
            
        case .deleteAction:
            currentAction.value = .noAction
            firstOperand = nil
            amountForShow.value = ""
            return AlertError(isError: false)
        }
        
        firstOperand = number
        amountForShow.value = ""
        isFractional = false
        isFirstOperation = false
        return AlertError(isError: false)
    }
    
    func acceptCloseKeyBoard() -> Bool {
        return name.count > 0 ? true : false
    }
    
    private func isZero() -> Bool {
        amountForShow.value == "0"
    }
    
    func saveMoneyAction() -> AlertError {
        guard let moneyCount = firstOperand, moneyCount > 0 else { return  AlertError(isError: true, message: "Write Correct number")}
        guard name.count > 0 else { return AlertError(isError: true, message: "Write Correct name") }
        StorageManager.shared.changeMoneyAction(action: editMoneyAction, name: name, date: date, moneyCount: moneyCount)
         return AlertError(isError: false)
    }
    
}
