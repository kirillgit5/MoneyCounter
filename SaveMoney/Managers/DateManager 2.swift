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
    
    func formatDateToStringDetailHeader(date: Date) -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let currentYearComponets = calendar.dateComponents([.year], from: currentDate)
        let currentDayComponets = calendar.dateComponents([.day], from: currentDate)
        let currentMounthComponets = calendar.dateComponents([.month], from: currentDate)
        
        let yearComponets = calendar.dateComponents([.year], from: date)
        let mounthComponets = calendar.dateComponents([.month], from: date)
        let dayComponets = calendar.dateComponents([.day], from: date)
        let weekDay = calendar.dateComponents([.weekday], from: date)
        
        guard let year = yearComponets.year ,
            let day = dayComponets.day,
            let weekday = weekDay.weekday,
            let mount = mounthComponets.month,
            let mounthTextRus = NumberedMonthsRus(rawValue: mount),let weekdayString =  WeekDays(rawValue: weekday) else { return  ""}
        
        if  let currentYear = currentYearComponets.year, let currentMount = currentMounthComponets.month, let currentDay = currentDayComponets.day  {
            if year == currentYear, mount == currentMount, day == currentDay {
                return "Сегодня"
            } else {
                if year == currentYear {
                    return "\(day) \(mounthTextRus), \(weekdayString)"
                } else {
                    return "\(day) \(mounthTextRus) \(year), \(weekdayString)"
                }
            }
        }
        return "\(day) \(mounthTextRus) \(year), \(weekdayString)"
    }
    
    func isEqualDates(firstDate: Date, secondDate: Date) -> Bool {
        let calendar = Calendar.current
        let startFirstDay = calendar.startOfDay(for: firstDate)
        let startSecondDay = calendar.startOfDay(for: secondDate)
        let difference = calendar.dateComponents([.year, .month, .day], from: startFirstDay, to: startSecondDay)
        print(difference.day == 0 && difference.month == 0 && difference.year == 0)
        return difference.day == 0 && difference.month == 0 && difference.year == 0
    }
    
    func isDatesContainsDate(dates: [Date], date: Date) -> Bool {
        for firstDate in dates {
            if isEqualDates(firstDate: firstDate, secondDate: date) {
                return true
            }
        }
        return false
    }
    
    func firstIndex(dates: [Date], date: Date) -> Int? {
        for (index, dateForCompare) in dates.enumerated() {
            if isEqualDates(firstDate: dateForCompare, secondDate: date) {
                return index
            }
        }
        return nil
    }
}
