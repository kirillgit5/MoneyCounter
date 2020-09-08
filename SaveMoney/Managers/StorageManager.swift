//
//  StorageManager.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 13.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import RealmSwift
class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    let realm = try! Realm()
    
    // MARK : - Private Methods
    
    func save(categories: [Category]) {
        write {
            realm.add(categories)
        }
    }
    func save(category: Category) {
        write {
            realm.add(category)
        }
    }
    
    
    func saveIncomeInMoneyCategory(moneyCategory: MoneyCategory, income: Income) {
        write {
            moneyCategory.incomes.append(income)
        }
    }
    
    func savePurchase(purchases: Purchases, purchasesCategory: PurchasesCategory, moneyCategory: MoneyCategory) {
        write {
            purchasesCategory.purchases.append(purchases)
            moneyCategory.purchases.append(purchases)
        }
        
    }
    
    func delete(action: MoneyAction) {
        write {
            realm.delete(action)
        }
        
    }
    
    func deleteAllData() {
        write {
            realm.deleteAll()
        }
    }
    
    func changeMoneyAction(action: MoneyAction, name: String, date: Date, moneyCount: Double) {
        write {
            action.name = name
            action.date = date
            action.moneyCount = moneyCount
        }
    }
    
    
    func createStandartDataMoneyCategory() {
        var moneyCategories = [Category]()
        for name in DataManager.shared.namesForStandartMoneyCategories {
            let moneyCategory = CategoryCreator.shared.createCategory(categoryType: .moneyCategory, name: name, iconName: name)
            moneyCategories.append(moneyCategory)
        }
        save(categories: moneyCategories)
    }
    
    func createStandartDataPurchasesCategory() {
        var purchasesCategories = [Category]()
        for name in DataManager.shared.namesForStandartPurchasesCategories {
            let purchasesCategory = CategoryCreator.shared.createCategory(categoryType: .purchasesCategory, name: name, iconName: name)
            purchasesCategories.append(purchasesCategory)
        }
        save(categories: purchasesCategories)
    }
    private func write(_ completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print(error)
        }
    }
}
