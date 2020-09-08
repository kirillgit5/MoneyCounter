//
//  Extension + Double.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 04.08.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

extension Double {
    func toString() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        return formatter.string(from: NSNumber(floatLiteral: self))!
    }
    
    func formatToShow() -> String {
        if  self < 1000000 {
            return "\(self.toString()) ₽"
        } else if self < 100000000{
            var ch = self
            let thousands = Int(ch/1000)
            ch = ch - Double(thousands) * 1000
            return ch == 0 ? "\(thousands)k ₽" : "\(thousands)k+ ₽"
        } else {
            var ch = self
            let millions = Int(ch/1000000)
            ch = ch - Double(millions) * 1000000
            return ch == 0 ? "\(millions)M ₽" : "\(millions)M+ ₽"
        }
    }
}

extension Double {
   func rounded(toPlaces places:Int) -> Double {
       let divisor = pow(10.0, Double(places))
       return (self * divisor).rounded() / divisor
   }
}


