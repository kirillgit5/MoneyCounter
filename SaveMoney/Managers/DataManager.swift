//
//  DataManager.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 18.08.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

final class DataManager {
    
    static let shared = DataManager()
    
    let iconNames = ["Cash", "Bank Account", "Marks", "Food", "Street Food", "Transport", "Clothing", "Entertainment", "Service", "Medicine" , "Household products"]
    
    let namesForStandartMoneyCategories = ["Cash", "Bank Account", "Marks"]
    let namesForStandartPurchasesCategories = ["Food", "Street Food", "Transport", "Clothing", "Entertainment", "Service", "Medicine" , "Household products"]
    
    private init() {}
}

