//
//  DateManager.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 15.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

class DateManager {
    
    static let shared = DateManager()
    
    private init() {}
    
    func firstDayOfMonth(date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components)!
    }
    
    func formatDateToString(date: Date) -> String {
        let calendar = Calendar.current
        let yearComponets = calendar.dateComponents([.year], from: date)
        let mounthComponets = calendar.dateComponents([.month], from: date)
        let dayComponets = calendar.dateComponents([.day], from: date)
        guard let year = yearComponets.year , let day = dayComponets.day, let mount = mounthComponets.month,
            let mounthTextEng = NumberedMonthsRus(rawValue: mount) else { return "" }
        return "\(day) \(mounthTextEng) \(year)"
    }
    
}
