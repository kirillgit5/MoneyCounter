//
//  SortManager.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 13.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation
import RealmSwift
class SortManager {
    static let shared = SortManager()
    
    private init() {}
    
    // MARK: - Public Methods
    func sortMoneyActionsByDate( moneyActions:  [MoneyAction]) -> [[MoneyAction]] {
        let actionsSort = moneyActions.sorted { $0.date > $1.date }
        let calendar = Calendar.current
        var sortedActions = [[MoneyAction]]()
        var actionsGroup = [MoneyAction]()
        guard let date = actionsSort.first?.date else { return sortedActions }
        var lastDate = calendar.startOfDay(for: date)
        for action in actionsSort {
            let currentDate = calendar.startOfDay(for: action.date)
            let difference = calendar.dateComponents([.year, .month, .day], from: currentDate, to: lastDate)
            if difference.day! != 0 || difference.month! != 0 || difference.year != 0 {
                lastDate = currentDate
                sortedActions.append(actionsGroup)
                actionsGroup = [action]
            } else {
                actionsGroup.append(action)
            }
        }
        sortedActions.append(actionsGroup)
        return sortedActions
    }
    
    func sortPurshasesByDate( purshase: List<Purchases>) -> [[MoneyAction]] {
        let purshaseSort = purshase
        let calendar = Calendar.current
        var sortedPurchases = [[MoneyAction]]()
        var purchasesGroup = [MoneyAction]()
        var lastDate = purshaseSort.first?.date
        for incom in purshaseSort {
            let currentDate = incom.date
            let difference = calendar.dateComponents([.year, .month, .day], from: lastDate!, to: currentDate)
            if difference.year! > 0 || difference.month! > 0 || difference.day! > 0 {
                lastDate = currentDate
                purchasesGroup.reverse()
                sortedPurchases.append(purchasesGroup)
                purchasesGroup = [incom]
            } else {
                purchasesGroup.append(incom)
            }
        }
        sortedPurchases.append(purchasesGroup)
        return sortedPurchases.reversed()
    }
}
