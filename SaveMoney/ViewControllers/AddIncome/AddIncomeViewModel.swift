//
//  AddIncomeViewModel.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 09.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import RealmSwift
protocol AddIncomeViewModelProtocol {
    init(moneyCategories: Results<MoneyCategory>)
    func getNavigationBarTitile() -> String
    func getInfoText() -> String
    func selectItem(at indexPath: IndexPath)
    func numberOfItems() -> Int
    func cellViewModal(for indexPath: IndexPath) -> MoneyCategoryCollectionViewCellViewModelProtocol
     func viewModelForCreateVC() -> CreateMoneyActionViewModelProtocol?
}

class AddIncomeViewModel: AddIncomeViewModelProtocol {
    
    private var indexPath: IndexPath?
    
    private let moneyCategories: Results<MoneyCategory>
    
    required init(moneyCategories: Results<MoneyCategory>) {
        self.moneyCategories = moneyCategories
    }
    
    func getNavigationBarTitile() -> String {
        "Добавление дохода"
    }
    
    func getInfoText() -> String {
        "Выберите счет"
    }
    
    func selectItem(at indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    func numberOfItems() -> Int {
        moneyCategories.count
    }
    
    func cellViewModal(for indexPath: IndexPath) -> MoneyCategoryCollectionViewCellViewModelProtocol {
        MoneyCategoryCollectionViewCellViewModel(category: moneyCategories[indexPath.row])
    }
    
    func viewModelForCreateVC() -> CreateMoneyActionViewModelProtocol? {
        guard let indexPath = indexPath else { return nil }
        return CreateMoneyActionViewModel(categoryForAdd: moneyCategories[indexPath.item])
    }
}
