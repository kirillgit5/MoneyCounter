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
    case addPurchases
    case createIncome
    case chooseMoneyCategory
    case createPurchases
    case editMoneyAction
    case detailAllCategories
    case editMoneyActionForAllCategories
    case addCategory
    case chooseIconForCategory
    case showTaskList
    case addIncome
}

enum CalculateActionWithNumber: String {
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
    case delete
    case writePoint
    
    
}

enum CalculateActionWithOperate: String {
    case doAddition = "+"
    case doSubtraction = "-"
    case doMultiplication = "×"
    case doDivision = "÷"
    case doPersent = "%"
    case noAction = ""
    case deleteAction
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
    case delete
    case writePoint
    case doAddition
    case doSubtraction
    case doMultiplication
    case doDivision
    case doPersent
    case noAction 
    case deleteAction
    case writeActionName
    case calculateResult
}

enum NumberedMonthsEng : Int {
    case january = 1 , february, march, april, may, june, july, august, september, october, november, december
}



enum NumberedMonthsRus : Int {
    case январь = 1, февраль, март, апрель, май, июнь, июль, август, сентябрь, октябрь, ноябрь, декабрь
}

enum WeekDays: Int {
    case  вс = 1, пон, вт, ср, чт, пят, суб
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
    case noAction
    case createSection
//    case reloadRow
}

enum CategoriesType {
    case moneyCategory
    case purchasesCategory
}

enum MoneyActionType {
    case income
    case purchases
}

enum StyleMoneyCategoryCell {
    
}
