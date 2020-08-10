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
    func sortIncomesByDate( incomes:  List<Income>) -> [[MoneyAction]] {
        let incomsSort = incomes.sorted { $0.date < $1.date }
        let calendar = Calendar.current
        var sortedIncoms = [[MoneyAction]]()
        var incomsGroup = [MoneyAction]()
        var lastDate = incomsSort.first?.date
        for incom in incomsSort {
            let currentDate = incom.date
            let difference = calendar.dateComponents([.year, .month, .day], from: lastDate!, to: currentDate)
            if difference.year! > 0 || difference.month! > 0 || difference.day! > 0 {
                lastDate = currentDate
                sortedIncoms.append(incomsGroup)
                incomsGroup = [incom]
            } else {
                incomsGroup.append(incom)
            }
        }
        sortedIncoms.append(incomsGroup)
        return sortedIncoms
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
        print(sortedPurchases.reversed())
        return sortedPurchases.reversed()
    }
}
