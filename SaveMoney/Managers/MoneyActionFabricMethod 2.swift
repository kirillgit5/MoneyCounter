//
//  MoneyActionFabricMethod.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 28.08.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import RealmSwift

protocol MoneyActionCreatorProtocol {
    func createMoneyAction(moneyActionType: MoneyActionType, name: String, date: Date, moneyCount: Double ) -> MoneyAction
}

final class MoneyActionCreator: MoneyActionCreatorProtocol {
    
    static let shared = MoneyActionCreator()
    
    private init() {}
    
    func createMoneyAction(moneyActionType: MoneyActionType, name: String, date: Date, moneyCount: Double) -> MoneyAction {
        switch moneyActionType {
        case .income:
            return Income(value: ["name": name, "date": date, "moneyCount": moneyCount])
        case .purchases:
            return Purchases(value: ["name": name, "date": date, "moneyCount": moneyCount])
        }
    }
}
