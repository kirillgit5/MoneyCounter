//
//  Enums.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 19.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

enum SegueIndentifire: String {
    case showDetailCategory
    case addMoneyAction
    case createIncome
    case chooseMoneyCategory
    case createPurchases
    case editMoneyAction
}

enum CalculateAction: String {
    case writeNull
    case writeOne
    case writeTwo
    case writeThree
    case writeFour
    case writeFive
    case writeSix
    case writeSeven
    case writeEight
    case writeNine
    case writeActionName
    case doAddition
    case doSubtraction
    case doMultiplication
    case doDivision
    case result
    case delete
    case doPersent
    case unknow
    case writePoint
    case noAction
    case deleteAction
}

enum NumberedMonthsEng : Int {
    case january = 1 , february, march, april, may, june, july, august, september, october, november, december
}



enum NumberedMonthsRus : Int {
    case январь = 1, февраль, март, апрель, май, июнь, июль, август, сентябрь, октябрь, ноябрь, декабрь
}

enum WeekDays: Int {
    case пн = 1, вт, ср, чт, пят, суб, вс
}

enum MoneyСategoryType: String, CaseIterable {
    case cash = "Cash"
    case bankAccount = "Bank Account"
    case totalScore  = "Total Score"
    case marks = "Marks"
}


enum TypeOfPurchases: String, CaseIterable {
    case food = "Food"
    case streetFood = "Street Food"
    case transport = "Transport"
    case clothing = "Clothing"
    case entertainment = "Entertainment"
    case services = "Service"
    case medicine = "Medicine"
    case householdProducts = "Household products"
}

enum ChangeMoneyActionType {
    case reloadSection
    case moveSection
    case moveRow
    case removeSection
    case reloadData
}
