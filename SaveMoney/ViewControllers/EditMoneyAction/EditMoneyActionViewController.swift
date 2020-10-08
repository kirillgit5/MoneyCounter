//
//  EditMoneyActionViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 16.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import RealmSwift
protocol UpdateTableViewDateDelegate: class {
    func changeIndexPath(date: Date)
}


class EditMoneyActionViewController: UIViewController {
    
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
    
    
    var viewModel: EditMoneyActionViewModelProtocol! 
    var updateTableViewDelegate: UpdateTableViewDateDelegate?
    
    // MARK : Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        navigationBar.title.text = viewModel.getNavigationBarTitile()
        dateChooseView.dateLabel.text = viewModel.getDateForShow()
        navigationBar.delegat = self
        textView.delegate = self
        dateChooseView.delegate = self
        setupKeyBoard()
        setupCalculatorViews()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        super.viewWillDisappear(true)
    }
    
    // MARK : Private Methods
    
    private func setupUI() {
        navigationBar.title.text = viewModel.getNavigationBarTitile()
        dateChooseView.dateLabel.text = viewModel.getDateForShow()
        
        viewModel.amountForShow.bind { [unowned self] (amount) in
            self.calculateScreen.calculateLabel.text = amount
        }
        
        viewModel.currentAction.bind { [unowned self] (action) in
            self.calculateScreen.operationTypeLabel.text = action.rawValue
        }
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
        viewModel.setName(name: textView.text ?? "")
        if viewModel.acceptCloseKeyBoard() {
            textView.resignFirstResponder()
            textView.isHidden = true
            calculateView.isHidden = false
            textView.frame.origin.y = textView.frame.origin.y + 180
        } else {
            showAlert(title: "Внимание !", message: "Введите название действия")
        }
    }
    
    deinit {
        print()
    }
}

extension EditMoneyActionViewController: AddMoneyActionNavigationBarDelegate {
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func createMoneyAction() {
        updateTableViewDelegate?.changeIndexPath(date: viewModel.getDate())
        let error = viewModel.saveMoneyAction()
        if !error.isError {
        navigationController?.popToRootViewController(animated: true)
        } else {
            showAlert(title: "Внимание!", message: error.message)
        }
    }
        
}


extension EditMoneyActionViewController: CalculateViewDelegate {
    func writeSymbol(action: CalculateActionWithNumber) {
        viewModel.processActionWithNumber(action: action)
    }
    
    func doOperate(operate: CalculateActionWithOperate) {
        let alertError = viewModel.operateActionWitOperation(action: operate)
        if  alertError.isError {
            showAlert(title: "Внимание!", message: alertError.message)
        }
    }
    
    func writeResult() {
        let alertError = viewModel.getResult()
        if alertError.isError {
            showAlert(title: "Внимание!", message: alertError.message)
        }
    }
    

    
    
    func writeActionName() {
        calculateView.isHidden = true
        textView.isHidden  = false
        textView.becomeFirstResponder()
        textView.text = viewModel.getName()
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.textView.frame.origin.y = self.calculateScreen.frame.maxY + 8
        }
        
    }
}

extension EditMoneyActionViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let text = textView.text , text.count > 150 {
            return false
        }
        return true
    }
}

extension EditMoneyActionViewController: DateChooseViewDelegate {
    func chooseDate() {
        let alert = UIAlertController(style: .actionSheet, source: view)
        let locale = Locale(identifier: "ru_RU")
        alert.addDatePicker(date: viewModel.getDate(), locale: locale) { [weak self] date in
            guard let self = self else { return }
            self.viewModel.setDate(date: date)
            self.dateChooseView.dateLabel.text = self.viewModel.getDateForShow()
        }
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        alert.show(animated: true, vibrate: false, viewController: self)
    }
}
