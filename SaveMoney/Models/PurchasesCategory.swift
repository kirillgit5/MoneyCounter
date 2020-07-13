//
//  PurchasesCategory.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 25.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import RealmSwift
class PurchasesCategory: Object {
    @objc dynamic var name = ""
    var purchases = List<Purchases>()
    var moneyCount: Double {
       var sum = 0.0
        purchases.forEach { (purchases) in
            sum += purchases.moneyCount
        }
        return sum
    }
}

class Purchases: Object {
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    @objc dynamic var moneyCount = 0.0
    @objc dynamic var descriptions: String?
}





