//
//  DateManager.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 24.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    var moneyCategoryes = MoneyCategory.getMoneyCategoryes()
    var purchasesCategory = PurchasesCategory.getPurchasesCategoryes()
}
