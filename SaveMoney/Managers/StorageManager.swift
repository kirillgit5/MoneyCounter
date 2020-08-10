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
    func save(moneyCategory: MoneyCategory...) {
        do {
            try realm.write{
                realm.add(moneyCategory)
            }
        } catch {
            print(error)
        }
    }
    
    func save(purchasesCategory: PurchasesCategory...) {
        do {
            try realm.write{
                realm.add(purchasesCategory)
            }
        } catch {
            print(error)
        }
    }
    
    func saveIncomeInMoneyCategory(moneyCategory: MoneyCategory, income: Income) {
        do {
            try realm.write {
                moneyCategory.incomes.append(income)
            }
        } catch {
            print(error)
        }
    }
    
    func savePurchase(purchases: Purchases, purchasesCategory: PurchasesCategory, moneyCategory: MoneyCategory) {
        do {
            try realm.write {
                purchasesCategory.purchases.append(purchases)
                moneyCategory.purchases.append(purchases)
            }
        } catch {
            print(error)
        }
    }
    
    
    func createStandartDataMoneyCategory() {
        let mc1 = MoneyCategory(value: ["name": "Cash"])
        let mc2 = MoneyCategory(value: ["name": "Bank Account"])
        var mc3 = MoneyCategory(value: ["name": "Marks"])
        save(moneyCategory: mc1,mc2,mc3)
    }
    
    func createStandartDataPurchasesCategory() {
        let pc1 = PurchasesCategory(value: ["name": "Food"])
        let pc2 = PurchasesCategory(value: ["name": "Street Food"])
        let pc3 = PurchasesCategory(value: ["name": "Transport"])
        let pc4 = PurchasesCategory(value: ["name": "Clothing"])
        let pc5 = PurchasesCategory(value: ["name": "Entertainment"])
        let pc6 = PurchasesCategory(value: ["name": "Service"])
        let pc7 = PurchasesCategory(value: ["name": "Medicine"])
        let pc8 = PurchasesCategory(value: ["name": "Household products"])
        save(purchasesCategory: pc1,pc2,pc3,pc4,pc5,pc6,pc7,pc8)
    }
}
