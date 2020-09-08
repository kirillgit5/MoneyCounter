//
//  CategoryCreaterProtocol.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 28.08.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import RealmSwift

protocol CategoryCreatorProtocol {
    func createCategory(categoryType: CategoriesType, name: String, iconName: String, startAmount: Double?) -> Category
}

final class CategoryCreator: CategoryCreatorProtocol {
    
    static let shared = CategoryCreator()
    
    private init() {}
    
    func createCategory(categoryType: CategoriesType, name: String, iconName: String, startAmount: Double? = nil) -> Category {
        switch categoryType {
        case .moneyCategory:
            guard let startAmount = startAmount else { return  MoneyCategory(value: ["name": name, "iconName": iconName]) }
            return  MoneyCategory(value: ["name": name, "iconName": iconName, "startAmount": startAmount])
        case .purchasesCategory:
            return PurchasesCategory(value: ["name": name, "iconName": iconName])
        }
    }
}
