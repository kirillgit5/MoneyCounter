//
//  MainMenuViewModel.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 12.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation


protocol MainMenuViewModelProtocol {
    func numberOfItemsForMoneyColletion() -> Int
    func numberOfItemsForPurhasesCollection()  -> Int
    func getAddMoneyCategoryCellIdentifire() -> String
    func getAddPurchasesCategoryCellIdentifire() -> String
    func getAddIncomeViewModel() -> AddIncomeViewModelProtocol
    func getAddPurshasesViewModel() -> AddPurshaeseViewModelProtocol
}

class MainMenuViewModel: MainMenuViewModelProtocol {
    
    private var moneyCategories = StorageManager.shared.realm.objects(MoneyCategory.self)
    private var purchasesCategories = StorageManager.shared.realm.objects(PurchasesCategory.self)
    
    func numberOfItemsForMoneyColletion() -> Int {
        moneyCategories.count
    }
    
    func numberOfItemsForPurhasesCollection() -> Int {
        purchasesCategories.count
    }
    
    func getAddMoneyCategoryCellIdentifire() -> String {
        "addMoneyCategory"
    }
    
    func getAddPurchasesCategoryCellIdentifire() -> String {
        "addPurchasesCategory"
    }
    
    func getAddIncomeViewModel() -> AddIncomeViewModelProtocol {
        AddIncomeViewModel(moneyCategories: moneyCategories)
    }
    
    func getAddPurshasesViewModel() -> AddPurshaeseViewModelProtocol {
        AddPurshasesViewModel(purshasesCategory: purchasesCategories)
    }
    
    
}
