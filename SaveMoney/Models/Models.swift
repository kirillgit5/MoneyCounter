//
//  MoneyCategory.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 24.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import RealmSwift



class Category: Object {
    @objc dynamic var name = ""
    @objc dynamic var iconName = ""
}


class MoneyAction: Object {
    
    
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    @objc dynamic var moneyCount = 0.0
    
    func copy() -> MoneyAction {
        MoneyAction(value: ["name": name, "date": date, "moneyCount": moneyCount])
    }
}


class MoneyCategory: Category {
    @objc dynamic var startAmount = 0.0
    var incomes = List<Income>()
    var purchases = List<Purchases>()
    
    var allActions: [MoneyAction] {
        var actions = [MoneyAction]()
        incomes.forEach { actions.append($0) }
        purchases.forEach{ actions.append($0) }
        return actions
    }
    
    var moneyCount: Double {
        var moneyCount = 0.0
        incomes.forEach { (incomes) in
            moneyCount += incomes.moneyCount
        }
        purchases.forEach { (purchases) in
            moneyCount -= purchases.moneyCount
        }
        moneyCount += startAmount
        return moneyCount
    }
}



class PurchasesCategory:  Category {
    
    var purchases = List<Purchases>()
    
    var moneyCount: Double {
        var sum = 0.0
        purchases.forEach { (purchases) in
            sum += purchases.moneyCount
        }
        return sum
    }
}


class Purchases:  MoneyAction {
    let purchasesCategory = LinkingObjects(fromType: PurchasesCategory.self, property: "purchases")
}

class Income: MoneyAction {
    let moneyCategory = LinkingObjects(fromType: MoneyCategory.self, property: "incomes")
}



