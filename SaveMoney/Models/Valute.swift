//
//  Valute.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 27.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

struct Valute {
    var money: Double
    let valuteCategory: ValuteCategory
    var moneyWithValuteCategory: String {
        "\(money) \(valuteCategory.rawValue)"
    }
}


enum ValuteCategory: String  {
    case ruble = "₽"
    case dollar = "$"
    case euro = "€"
}
