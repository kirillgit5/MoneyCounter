//
//  AddMoneyActionModelView.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 09.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import RealmSwift

protocol AddPurshaeseViewModelProtocol {
    init(purshasesCategory: Results<PurchasesCategory>)
    func getNavigationBarTitile() -> String
    func getInfoText() -> String
    func selectItem(at indexPath: IndexPath)
    func numberOfItems() -> Int
    func cellViewModal(for indexPath: IndexPath) -> PurchasesCategoryCollectionViewCellViewModelProtocol
    func viewModelForSelectedRow() -> ChooseMoneyCategoryViewModelProtocol?
}

class AddPurshasesViewModel: AddPurshaeseViewModelProtocol {
    
    //MARK: - Private Property
    private var purshasesCategory: Results<PurchasesCategory>
    private var indexPath: IndexPath?
    
    required init(purshasesCategory: Results<PurchasesCategory>) {
        self.purshasesCategory = purshasesCategory
    }
    
    //MARK: - Public Methods
    
    func getNavigationBarTitile() -> String {
        "Добавление расхода"
        
    }
    
    func getInfoText() -> String {
        return "Выберите категорию расхода"
    }
    
    func selectItem(at indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    func numberOfItems() -> Int {
        purshasesCategory.count
    }
    
    func cellViewModal(for indexPath: IndexPath) -> PurchasesCategoryCollectionViewCellViewModelProtocol {
        PurchasesCategoryCollectionViewCellViewModel(category: purshasesCategory[indexPath.item])
    }
    
    func viewModelForSelectedRow() -> ChooseMoneyCategoryViewModelProtocol? {
        guard let indexPath = indexPath else { return nil }
        return ChooseMoneyCategoryViewModel(purshasesCategory: purshasesCategory[indexPath.item])
    }
}
