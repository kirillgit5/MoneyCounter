//
//  ChooseMoneyCategoryViewModal.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 09.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import RealmSwift

protocol ChooseMoneyCategoryViewModelProtocol {
    init(purshasesCategory: PurchasesCategory)
    func numberOfRows() -> Int
    func getInfoText() -> String
    func getNavigationBarTitle() -> String
    func getMoneyCategory(for indexPath: IndexPath) -> MoneyCategory
    func selectItem(at indexPath: IndexPath)
    func cellViewModal(for indexPath: IndexPath) -> MoneyCategoryCollectionViewCellViewModelProtocol
    func viewModelForCreateVC() -> CreateMoneyActionViewModelProtocol?
}

class ChooseMoneyCategoryViewModel: ChooseMoneyCategoryViewModelProtocol {
    
    // MARK: - Private Property
    private let purshasesCategory: PurchasesCategory
    private let infoText = "Выберите счет"
    private let navigationBarTitle = "Добавление расхода"
    private let moneyCategories: Results<MoneyCategory>
    private var indexPath: IndexPath?
    
    required init(purshasesCategory: PurchasesCategory) {
        self.purshasesCategory = purshasesCategory
        moneyCategories = StorageManager.shared.realm.objects(MoneyCategory.self)
    }
    
    //MARK : - Public Methods
    func numberOfRows() -> Int {
        moneyCategories.count
    }
    
    func getInfoText() -> String {
        infoText
    }
    
    func getNavigationBarTitle() -> String {
        navigationBarTitle
    }
    
    func getMoneyCategory(for indexPath: IndexPath) -> MoneyCategory {
        moneyCategories[indexPath.row]
    }
    
    func selectItem(at indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    func cellViewModal(for indexPath: IndexPath) -> MoneyCategoryCollectionViewCellViewModelProtocol {
        MoneyCategoryCollectionViewCellViewModel(category: moneyCategories[indexPath.item])
    }
    
    func viewModelForCreateVC() -> CreateMoneyActionViewModelProtocol? {
        guard let indexPath = indexPath else { return nil }
        return CreateMoneyActionViewModel(categoryForAdd: purshasesCategory, moneyCategory: moneyCategories[indexPath.item])
        
    }
}
