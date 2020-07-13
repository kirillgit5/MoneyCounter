//
//  MoneyCategory.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 24.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import RealmSwift
class MoneyCategory: Object {
    @objc dynamic var name = ""
    var income = List<Income>()
    var moneyCount: Double {
       var sum = 0.0
        income.forEach { (income) in
            sum += income.moneyCount
        }
        return sum
    }
    
}

class Income: Object {
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    @objc dynamic var moneyCount = 0.0
    @objc dynamic var descriptions: String?
    
}








