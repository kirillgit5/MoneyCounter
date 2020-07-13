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
    
    func createNewDataM() {
        var mc1 = MoneyCategory(value: ["name": "Cash"])
        var mc2 = MoneyCategory(value: ["name": "Bank Account"])
        var mc3 = MoneyCategory(value: ["name": "Marks"])
        save(moneyCategory: mc1,mc2,mc3)
    }
    
    func createNewDataP() {
        var mc1 = PurchasesCategory(value: ["name": "Food"])
        var mc2 = PurchasesCategory(value: ["name": "Street Food"])
        var mc3 = PurchasesCategory(value: ["name": "Transport"])
        var mc4 = PurchasesCategory(value: ["name": "Clothing"])
        var mc5 = PurchasesCategory(value: ["name": "Entertainment"])
        var mc6 = PurchasesCategory(value: ["name": "Service"])
        var mc7 = PurchasesCategory(value: ["name": "Medicine"])
        var mc8 = PurchasesCategory(value: ["name": "Household products"])
        save(purchasesCategory: mc1,mc2,mc3,mc4,mc5,mc6,mc7,mc8)
    }
    
    
}
enum MoneyСategoryType: String, CaseIterable {
    case cash = "Cash"
    case bankAccount = "Bank Account"
    case totalScore  = "Total Score"
    case marks = "Marks"
}


enum TypeOfPurchases: String, CaseIterable {
    case food = "Food"
    case streetFood = "Street Food"
    case transport = "Transport"
    case clothing = "Clothing"
    case entertainment = "Entertainment"
    case services = "Service"
    case medicine = "Medicine"
    case householdProducts = "Household products"
}

