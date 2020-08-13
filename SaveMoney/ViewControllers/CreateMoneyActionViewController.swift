//
//  CreateMoneyActionViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 19.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import RealmSwift

protocol UpdateTableViewDateDelegate {
    func changeIndexPath(date: Date)
}

class CreateMoneyActionViewController: UIViewController {
    
    // MARK : IB Outlets
    @IBOutlet var calculateView: UIView!
    @IBOutlet var calculateScreen: CalculaterScreen!
    @IBOutlet var deleteActionView: CalculateView!
    @IBOutlet var nameView: CalculateView!
    @IBOutlet var percentView: CalculateView!
    @IBOutlet var additionView: CalculateView!
    @IBOutlet var numberOneView: CalculateView!
    @IBOutlet var numberTwoView: CalculateView!
    @IBOutlet var numberThreeView: CalculateView!
    @IBOutlet var numberFourView: CalculateView!
    @IBOutlet var numberFiveView: CalculateView!
    @IBOutlet var numberSixView: CalculateView!
    @IBOutlet var numberSevenView: CalculateView!
    @IBOutlet var numberEightView: CalculateView!
    @IBOutlet var numberNineView: CalculateView!
    @IBOutlet var numberNullView: CalculateView!
    @IBOutlet var deleteView: CalculateView!
    @IBOutlet var pointView: CalculateView!
    @IBOutlet var resultsView: CalculateView!
    @IBOutlet var divisionView: CalculateView!
    @IBOutlet var multView: CalculateView!
    @IBOutlet var substractionView: CalculateView!
    
    @IBOutlet var navigationBar: AddMoneyActionNavigationBar!
    @IBOutlet var textView: UITextView!
    @IBOutlet var dateChooseView: DateChooseView!
    
    
    // MARK : Public Property
    var categoryForAdd: Category!
    var categoryForBuy: MoneyCategory?
    var editMoneyAction: MoneyAction?
    var updateTableViewDelegate: UpdateTableViewDateDelegate?
    
    // MARK : Private Property
    private var actionName: String?
    private var firstNumber: Double?
    private var resultNumber: Double?
    private var currentAction = CalculateAction.noAction
    private var actionDate = Date()
    
    
    // MARK : Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if editMoneyAction != nil {
            navigationController?.isNavigationBarHidden = true
            navigationBar.title.text = "Редактирование"
            navigationBar.setupNavBarSecondType()
            actionDate = editMoneyAction!.date
            actionName = editMoneyAction!.name
            calculateScreen.calculateLabel.text = editMoneyAction!.moneyCount.toString()
        } else {
            setupNaigationBarForChoose()
        }
        navigationBar.delegat = self
        textView.delegate = self
        dateChooseView.delegate = self
        dateChooseView.dateLabel.text = DateManager.shared.formatDateToString(date: actionDate)
        setupKeyBoard()
        setupCalculatorViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if editMoneyAction != nil {
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if editMoneyAction != nil {
            navigationController?.isNavigationBarHidden = false
        }
        super.viewWillDisappear(true)
    }
    
    // MARK : Private Methods
    private func setupNaigationBarForChoose() {
        if categoryForBuy != nil {
            navigationBar.title.text = "\(categoryForBuy!.name) -> \(categoryForAdd.name)"
        } else {
            navigationBar.title.text = "Получен доход в \(categoryForAdd.name)"
        }
        navigationBar.setupNavBarSecondType()
    }
    
    private func setupNavigationBarForChange() {
        
    }
    private func setupCalculatorViews() {
        nameView.delegate = self
        percentView.delegate = self
        additionView.delegate = self
        numberOneView.delegate = self
        numberTwoView.delegate = self
        numberThreeView.delegate = self
        numberFourView.delegate = self
        numberFiveView.delegate = self
        numberSixView.delegate = self
        numberSevenView.delegate = self
        numberEightView.delegate = self
        numberNineView.delegate = self
        numberNullView.delegate = self
        deleteView.delegate = self
        pointView.delegate = self
        resultsView.delegate = self
        divisionView.delegate = self
        multView.delegate = self
        substractionView.delegate = self
        deleteActionView.delegate = self
    }
    
    // MARK : Private Methods
    
    private func  calculatePercentageOfTheNumber(number: Double) -> Double {
        let persentNumber = firstNumber!/100
        return persentNumber * number
    }
    
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert,animated: true)
    }
    
    private func setupKeyBoard() {
        let bar = UIToolbar()
        let backButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(closeKeyBoard))
        let acceptButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(createActionName))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil )
        bar.items = [flexibleSpace, backButton, flexibleSpace, acceptButton, flexibleSpace]
        bar.sizeToFit()
        textView.inputAccessoryView = bar
    }
    
    
    @objc func closeKeyBoard() {
        textView.resignFirstResponder()
        textView.isHidden = true
        calculateView.isHidden = false
        textView.frame.origin.y = textView.frame.origin.y + 180
        textView.text = ""
    }
    
    @objc func createActionName() {
        if !textView.text.isEmpty {
            actionName = textView.text
            textView.resignFirstResponder()
            textView.isHidden = true
            calculateView.isHidden = false
            textView.frame.origin.y = textView.frame.origin.y + 180
        } else {
            showAlert(title: "Внимание !", message: "Введите название действия")
        }
    }
}

extension CreateMoneyActionViewController: AddMoneyActionNavigationBarDelegate {
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func addMoneyCategory() {
        
        if let text = calculateScreen.calculateLabel.text, !text.isEmpty , let moneyCount = Double(text), let name = actionName, currentAction == .noAction {
            if editMoneyAction != nil {
                if !DateManager.shared.isEqualDates(firstDate: actionDate, secondDate: editMoneyAction!.date) {
                updateTableViewDelegate?.changeIndexPath(date: actionDate)
                }
                StorageManager.shared.changeMoneyAction(action: editMoneyAction!, name: name, date: actionDate, moneyCount: moneyCount)
                navigationController?.popViewController(animated: true)
                
            } else if categoryForBuy == nil {
                guard let moneyCategory = categoryForAdd as? MoneyCategory else { return }
                let income = Income(value: ["name": name, "date": actionDate, "moneyCount": moneyCount])
                StorageManager.shared.saveIncomeInMoneyCategory(moneyCategory: moneyCategory, income: income)
                
            } else {
                guard let purchasesCategory = categoryForAdd as? PurchasesCategory else { return }
                guard let moneyCategory = categoryForBuy else { return }
                let purchases = Purchases(value: ["name": name, "date": actionDate, "moneyCount": moneyCount])
                StorageManager.shared.savePurchase(purchases: purchases, purchasesCategory: purchasesCategory, moneyCategory: moneyCategory)
            }
            
            dismiss(animated: true)
            
        } else {
            actionName == nil ?
                showAlert(title: "Внимание!", message: "Напишите название \(categoryForBuy == nil ? "дохода" : "покупки")") :
                showAlert(title: "Внимание!", message: "\(categoryForBuy == nil ? "Укажите полученный доход" : "Укажите стоимость покупки")")
        }
    }
}

extension CreateMoneyActionViewController: CalculateViewDelegate {
    func deleteAction() {
        calculateScreen.calculateLabel.text?.removeAll()
        firstNumber = nil
        currentAction = CalculateAction.noAction
        calculateScreen.operationTypeLabel.text = ""
    }
    
    func writeSymbol(symbol: Character) {
        if symbol == ".", let lastCharacter = calculateScreen.calculateLabel.text?.last, lastCharacter == "."  {
            return
        }
        
        if  symbol == ".",  calculateScreen.calculateLabel.text?.first == nil  {
            return
        }
        
        if symbol != "0" , let text = calculateScreen.calculateLabel.text, text.count == 1, text.first == "0" {
            if symbol != "." {
                calculateScreen.calculateLabel.text?.removeAll()
            }
            calculateScreen.calculateLabel.text?.append(symbol)
            return
        }
        calculateScreen.calculateLabel.text?.append(symbol)
    }
    
    func delete() {
        if let text = calculateScreen.calculateLabel.text, !text.isEmpty {
            calculateScreen.calculateLabel.text?.removeLast()
        }
    }
    
    func subtraction() {
        if let text = calculateScreen.calculateLabel.text, !text.isEmpty , let number = Double(text) , currentAction == CalculateAction.noAction {
            firstNumber = number
            calculateScreen.operationTypeLabel.text = "-"
            calculateScreen.calculateLabel.text = ""
            currentAction = CalculateAction.doSubtraction
        }
    }
    
    func multiplication() {
        if let text = calculateScreen.calculateLabel.text, !text.isEmpty , let number = Double(text), currentAction == CalculateAction.noAction {
            firstNumber = number
            calculateScreen.operationTypeLabel.text = "×"
            calculateScreen.calculateLabel.text = ""
            currentAction = CalculateAction.doMultiplication
        }
    }
    
    func division() {
        if let text = calculateScreen.calculateLabel.text, !text.isEmpty , let number = Double(text) , currentAction == CalculateAction.noAction {
            firstNumber = number
            calculateScreen.operationTypeLabel.text = "÷"
            calculateScreen.calculateLabel.text = ""
            currentAction =  CalculateAction.doDivision
        }
    }
    
    func addition() {
        if let text = calculateScreen.calculateLabel.text, !text.isEmpty , let number = Double(text) , currentAction == CalculateAction.noAction {
            firstNumber = number
            calculateScreen.operationTypeLabel.text = "+"
            calculateScreen.calculateLabel.text = ""
            currentAction = CalculateAction.doAddition
        }
    }
    
    func writeResult() {
        if let text = calculateScreen.calculateLabel.text, !text.isEmpty , let secondNumber = Double(text) , currentAction != CalculateAction.noAction , let firstNumber = firstNumber {
            switch currentAction {
            case .doAddition:
                calculateScreen.calculateLabel.text = (firstNumber + secondNumber).toString()
                self.firstNumber = firstNumber + secondNumber
                
            case .doDivision:
                if secondNumber == 0.0 {
                    calculateScreen.calculateLabel.text = ""
                    self.firstNumber = 0
                    
                } else {
                    calculateScreen.calculateLabel.text = (firstNumber / secondNumber).toString()
                    self.firstNumber = firstNumber / secondNumber
                }
                
            case .doMultiplication:
                calculateScreen.calculateLabel.text = (firstNumber * secondNumber).toString()
                self.firstNumber = firstNumber * secondNumber
                
            case .doSubtraction:
                if secondNumber > firstNumber {
                    calculateScreen.calculateLabel.text = ""
                    self.firstNumber = 0
                } else {
                    calculateScreen.calculateLabel.text = (firstNumber - secondNumber).toString()
                    self.firstNumber = firstNumber - secondNumber
                }
            case .doPersent:
                calculateScreen.calculateLabel.text =  calculatePercentageOfTheNumber(number: secondNumber).toString()
                self.firstNumber = calculatePercentageOfTheNumber(number: secondNumber)
                
            default:
                break
            }
        }
        calculateScreen.operationTypeLabel.text = ""
        currentAction = .noAction
        
    }
    
    func percent() {
        if let text = calculateScreen.calculateLabel.text, !text.isEmpty , let number = Double(text), currentAction == CalculateAction.noAction {
            firstNumber = number
            calculateScreen.operationTypeLabel.text = "%"
            calculateScreen.calculateLabel.text = ""
            currentAction = CalculateAction.doPersent
        }
    }
    
    
    func writeActionName() {
        calculateView.isHidden = true
        textView.isHidden  = false
        textView.becomeFirstResponder()
        textView.text = actionName
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.textView.frame.origin.y = self.calculateScreen.frame.maxY + 8
        }
        
    }
}

extension CreateMoneyActionViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let text = textView.text , text.count > 150 {
            return false
        }
        return true
    }
}

extension CreateMoneyActionViewController: DateChooseViewDelegate {
    func chooseDate() {
        let alert = UIAlertController(style: .actionSheet, source: view)
        let locale = Locale(identifier: "ru_RU")
        alert.addDatePicker(date: actionDate, locale: locale) { [weak self] date in
            guard let self = self else { return }
            self.actionDate = date
            self.dateChooseView.dateLabel.text = DateManager.shared.formatDateToString(date: self.actionDate)
        }
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        alert.show(animated: true, vibrate: false, viewController: self)
    }
}




