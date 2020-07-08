//
//  MoneyCategory.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 24.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

struct MoneyCategory {
    let categoryType: MoneyСategoryType
    var valute: Valute
    let description: String?
    var nameForImage: String {
        categoryType.rawValue
    }
}

extension MoneyCategory {
    static func getMoneyCategoryes() -> [MoneyCategory] {
        var moneyCategoryes = [MoneyCategory]()
        MoneyСategoryType.allCases.forEach { (moneyСategoryType)  in
            switch moneyСategoryType {
            case .cash:
                moneyCategoryes.append(MoneyCategory(categoryType: .cash,
                                                     valute: Valute(money: 0.0, valuteCategory: .ruble),
                                                     description: nil))
            case .bankAccount:
                moneyCategoryes.append(MoneyCategory(categoryType: moneyСategoryType ,
                                                     valute: Valute(money: 0.0, valuteCategory: .ruble),
                                                     description: nil))
            case .totalScore:
                moneyCategoryes.append(MoneyCategory(categoryType: moneyСategoryType ,
                                                     valute: Valute(money: 0.0, valuteCategory: .ruble),
                                                     description: nil))
            case .marks:
                moneyCategoryes.append(MoneyCategory(categoryType: moneyСategoryType ,
                                                     valute: Valute(money: 0.0, valuteCategory: .ruble),
                                                     description: nil))
                
                
            }
        }
        return moneyCategoryes
    }
}

enum MoneyСategoryType: String, CaseIterable {
    case cash = "Cash"
    case bankAccount = "Bank Account"
    case totalScore  = "Total Score"
    case marks = "Marks"
}



