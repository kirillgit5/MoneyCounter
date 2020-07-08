//
//  PurchasesCategory.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 25.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

struct  PurchasesCategory {
    let typeOfPurchases: TypeOfPurchases
    var valute: Valute
    var nameForImage: String {
        typeOfPurchases.rawValue
    }
    var purchases: [Purchases]
}

extension PurchasesCategory {
    static func getPurchasesCategoryes() -> [PurchasesCategory] {
        var purchasesCategory = [PurchasesCategory]()
        TypeOfPurchases.allCases.forEach { (typeOfPurchases)  in
            let category = PurchasesCategory(typeOfPurchases: typeOfPurchases,
                                             valute: Valute(money: 0.0, valuteCategory: .ruble) ,
                                             purchases: [Purchases]())
            purchasesCategory.append(category)
        }
        return purchasesCategory
    }
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



