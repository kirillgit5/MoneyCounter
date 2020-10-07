//
//  DetailCategoryViewModel.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 15.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import RealmSwift

struct TableViewAction {
    let type: ChangeMoneyActionType
    let indexPath: IndexPath
}


protocol DetailCategoryViewModelProtocol {
    init(moneyActions: [[MoneyAction]], rowType: CategoriesType, name: String)
    func getMoneyActions() -> [[MoneyAction]]
    func numberOfRows(in section: Int) -> Int
    func numberOfSections() -> Int
    func selectRows(at indexPath: IndexPath)
    func isMoneyCategory() -> Bool
    func getName() -> String
    func getCategoryType() -> CategoriesType
//    func getMoneyAction(at indexPath: IndexPath) -> MoneyAction
//    func getMoneyForShow(at indexPath: IndexPath) -> String
//    func getMoneyActionName(at indexPath: IndexPath) -> String
//    func viewModelForPurshasesCell(at inexPath: IndexPath) -> DetailPurchasesTableViewCellViewModelProtocol
//    func getMoneyActionsInSections(section: Int) -> [MoneyAction]
//    func deleteMoneyAction(at indexPath: IndexPath)
//    func isSectionIsEmpty(at indexPath: IndexPath) -> Bool
//    func deleteSection(at indexPath: IndexPath) -> Bool
//    func viewModelForEdit(at indexPath: IndexPath) -> EditMoneyActionViewModelProtocol
}

class DetailCategoryViewModel: DetailCategoryViewModelProtocol {

    private var changeMoneyActionType = ChangeMoneyActionType.noAction
    
    private var moneyActions: [[MoneyAction]]
    var indexPath: IndexPath?
    private var newIndexPath: IndexPath?
    private let rowType: CategoriesType
    private let name: String
    private var editMoneyAction: MoneyAction?
    
    required init(moneyActions: [[MoneyAction]], rowType: CategoriesType, name: String) {
        self.moneyActions = moneyActions
        self.rowType = rowType
        self.name = name
    }
    
    func numberOfRows(in section: Int) -> Int {
        moneyActions[section].count
        
    }
    
    
    func selectRows(at indexPath: IndexPath) {
        self.indexPath = indexPath
        editMoneyAction = moneyActions[indexPath.section][indexPath.row]
    }
    
    func numberOfSections() -> Int {
        moneyActions.count
    }
    

    
    func deleteSection(at indexPath: IndexPath) -> Bool {
        if moneyActions[indexPath.section].isEmpty {
            moneyActions.remove(at: indexPath.section)
            return true
        }
        return false
    }
    
    func isSectionIsEmpty(at indexPath: IndexPath) -> Bool {
        moneyActions[indexPath.section].isEmpty
    }
    
    func deleteMoneyAction(at indexPath: IndexPath)  {
        let moneyAction = moneyActions[indexPath.section].remove(at: indexPath.row)
        StorageManager.shared.delete(action: moneyAction)
    }
    

    
    func viewModelForPurshasesCell(at indexPath: IndexPath) -> DetailPurchasesTableViewCellViewModelProtocol {
        DetailPurchasesTableViewCellViewModel(moneyAction: moneyActions[indexPath.section][indexPath.item])
    }
    
    
    func getCategoryType() -> CategoriesType {
        rowType
    }
    
    func getName() -> String {
        name
    }
    
    func isMoneyCategory() -> Bool {
        rowType == .moneyCategory ? true : false
    }
    
    func getMoneyActions() -> [[MoneyAction]] {
           return moneyActions
       }
}
