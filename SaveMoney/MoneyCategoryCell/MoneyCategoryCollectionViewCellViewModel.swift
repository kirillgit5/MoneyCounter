//
//  MoneyCategoryCollectionViewCellViewModal.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 09.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import RealmSwift

protocol MoneyCategoryCollectionViewCellViewModelProtocol {
    
    init(category: MoneyCategory, isAddItem: Bool)
    func getCategoryName() -> String
    func getMoneyCount() -> String
    func getImageName() -> String
    func isMoneyCountFewerThenZero() -> Bool
    func getIsAddItem() -> Bool
}

class MoneyCategoryCollectionViewCellViewModel: MoneyCategoryCollectionViewCellViewModelProtocol {
    
    
    
    private let category: MoneyCategory
    private let isAddItem: Bool
    
    required init(category: MoneyCategory, isAddItem: Bool = false) {
        self.category = category
        self.isAddItem = isAddItem
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
    
    
    func isMoneyCountFewerThenZero() -> Bool {
         category.moneyCount < 0 ? true : false
    }
    
    func getIsAddItem() -> Bool {
        isAddItem
    }
    
    
}
