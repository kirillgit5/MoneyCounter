//
//  MainNavigationBar.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 24.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import RealmSwift

@objc protocol MainNavigationBarDelegate: class {
    @objc optional func watchBalance()
    @objc optional func watchExpense()
    @objc optional func watchPlan()
    @objc optional func addMoney()
    @objc optional func addExpense()
}

@IBDesignable class MainNavigationBar: UINavigationBar {
    
    //MARK: - IB Outlets
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var purseButton: UIButton!
    @IBOutlet var addExpenseButtton: UIButton!
    
    @IBOutlet var balanceCountLabel: UILabel!
    @IBOutlet var expensesCountLabel: UILabel!
    @IBOutlet var planCountLabel: UILabel!
    
    @IBOutlet var balanceButton: UIButton!
    @IBOutlet var expenseButton: UIButton!
    @IBOutlet var planButton: UIButton!
    
    //MARK : - Delegate
    weak var delegat: MainNavigationBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    //MARK : - IB Action
    @IBAction func watchBalance() {
        delegat?.watchBalance?()
    }
    @IBAction func watchExpenses() {
        delegat?.watchExpense?()
    }
    @IBAction func watchPlan() {
        delegat?.watchPlan?()
    }
    @IBAction func addMoney() {
        delegat?.addMoney?()
    }
    
    @IBAction func addExpense() {
        delegat?.addExpense?()
    }
    
    // MARK : - Public Methods
    func setBalance(moneyCatigories: Results<MoneyCategory>) {
        var sum = 0.0
        moneyCatigories.forEach { sum += $0.moneyCount }
        balanceCountLabel.text = "\(sum) ₽"
    }
    
    func setExpense(purchasesCatigories: Results<PurchasesCategory>) {
        var sum = 0.0
        purchasesCatigories.forEach { sum += $0.moneyCount }
        expensesCountLabel.text = "\(sum) ₽"
    }

    
    //MARK : - Private Methods
    private func commonInit() {
        let bundle = Bundle(for: MainNavigationBar.self)
        bundle.loadNibNamed("MainNavigationBarIB", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    
}


