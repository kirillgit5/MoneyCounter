//
//  MainMenuViewModel.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 12.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import RealmSwift

protocol MainMenuViewModelProtocol {
    func numberOfItems(collectionType: CategoriesType) -> Int
    func getAddMoneyCategoryCellIdentifire() -> String
    func getAddPurchasesCategoryCellIdentifire() -> String
    func getMoneyCategoriesCount() -> Int
    func getPurshasesCategoryCount() -> Int
    func getAddIncomeViewModel() -> AddIncomeViewModelProtocol
    func getAddPurshasesViewModel() -> AddPurshaeseViewModelProtocol
    func viewModelForDetailMoneyActions(at indexPath: IndexPath, collectionType: CategoriesType) -> DetailCategoryViewModelProtocol
    func cellMoneyCategoryViewModal(for indexPath: IndexPath) -> MoneyCategoryCollectionViewCellViewModelProtocol
    func cellViewModelPurchasesCategory(for indexPath: IndexPath) -> PurchasesCategoryCollectionViewCellViewModel
    func getBalance() -> String
    func getExpense() -> String
    func getViewModelForAddItem() -> MoneyCategoryCollectionViewCellViewModelProtocol
    func getTaskCount() -> String
    func getTaskList() -> Results<Task>
}

class MainMenuViewModel: MainMenuViewModelProtocol {

    private var indexPath: IndexPath?
    private var moneyCategories = StorageManager.shared.realm.objects(MoneyCategory.self)
    private var purchasesCategories = StorageManager.shared.realm.objects(PurchasesCategory.self)
    private var taskList = StorageManager.shared.realm.objects(Task.self)
    
    
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
    
    func cellMoneyCategoryViewModal(for indexPath: IndexPath) -> MoneyCategoryCollectionViewCellViewModelProtocol {
        MoneyCategoryCollectionViewCellViewModel(category: moneyCategories[indexPath.row])
    }
    
    
    func cellViewModelPurchasesCategory(for indexPath: IndexPath) -> PurchasesCategoryCollectionViewCellViewModel {
        PurchasesCategoryCollectionViewCellViewModel(category: purchasesCategories[indexPath.item])
    }
    
    func numberOfItems(collectionType: CategoriesType) -> Int {
        switch collectionType {
        case .moneyCategory:
            return moneyCategories.count + 1
        case .purchasesCategory:
            return purchasesCategories.count + 1
        }
    }
    
    func viewModelForDetailMoneyActions(at indexPath: IndexPath, collectionType: CategoriesType) -> DetailCategoryViewModelProtocol {
        switch collectionType {
        case .moneyCategory:
            let name = moneyCategories[indexPath.item].name
            let moneyActions = moneyCategories[indexPath.item].allActions
            let sortedMoneyActions = SortManager.shared.sortMoneyActionsByDate(moneyActions: moneyActions)
            return DetailCategoryViewModel(moneyActions: sortedMoneyActions, rowType: CategoriesType.moneyCategory,name: name)
        case .purchasesCategory:
            let name = purchasesCategories[indexPath.item].name
            let purchases = purchasesCategories[indexPath.item].purchases
            let sortedMoneyActions = SortManager.shared.sortMoneyActionsByDate(moneyActions: Array(purchases))
            return DetailCategoryViewModel(moneyActions: sortedMoneyActions, rowType: CategoriesType.purchasesCategory, name: name)
        }
    }
    
    func getMoneyCategoriesCount() -> Int {
        moneyCategories.count
    }
    
    func getPurshasesCategoryCount() -> Int {
        purchasesCategories.count
    }
    
    func getBalance() -> String {
        var sum = 0.0
        moneyCategories.forEach { sum += $0.moneyCount }
        return sum.formatToShow()
    }
    
    func getExpense() -> String {
        var sum = 0.0
        purchasesCategories.forEach { sum += $0.moneyCount }
        return sum.formatToShow()
    }
    
    func getTaskList() -> Results<Task> {
        taskList
    }
    
    func getTaskCount() -> String {
        "\(taskList.count)"
    }
    
    func getViewModelForAddItem() -> MoneyCategoryCollectionViewCellViewModelProtocol {
        MoneyCategoryCollectionViewCellViewModel(category: MoneyCategory(value: []), isAddItem: true)
    }
    
    
}
