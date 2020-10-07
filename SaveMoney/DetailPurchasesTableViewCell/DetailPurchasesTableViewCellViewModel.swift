//
//  DetailPurchasesTableViewCellViewModel.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 15.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation


protocol DetailPurchasesTableViewCellViewModelProtocol {
    init(moneyAction: MoneyAction)
    func getName() -> String
    func getAmount() -> String
}

class DetailPurchasesTableViewCellViewModel: DetailPurchasesTableViewCellViewModelProtocol {
    
    private let name: String
    private let amount: Double
    
    required init(moneyAction: MoneyAction) {
        name = moneyAction.name
        amount = moneyAction.moneyCount
    }
    
    func getName() -> String {
        name
    }
    
    func getAmount() -> String {
        amount.formatToShow()
    }
    
    
    
}
