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
        let tempVar = String(format: "%g", self)
        return tempVar
    }
}
