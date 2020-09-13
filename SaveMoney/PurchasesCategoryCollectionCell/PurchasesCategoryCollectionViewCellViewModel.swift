//
//  PurchasesCategoryCollectionViewCellViewModel.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 09.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import RealmSwift

protocol PurchasesCategoryCollectionViewCellViewModelProtocol {
    init(category: PurchasesCategory)
    func getCategoryName() -> String
    func getMoneyCount() -> String
    func getImageName() -> String
}

class PurchasesCategoryCollectionViewCellViewModel: PurchasesCategoryCollectionViewCellViewModelProtocol {
    private let category: PurchasesCategory
    
    required init(category: PurchasesCategory) {
        self.category = category
    }
    
    func getCategoryName() -> String {
        category.name
    }
    
    func getMoneyCount() -> String {
        category.moneyCount.formatToShow()
    }
    
    func getImageName() -> String {
        category.iconName
    }
}
