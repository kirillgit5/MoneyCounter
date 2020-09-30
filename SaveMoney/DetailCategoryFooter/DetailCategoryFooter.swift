//
//  DetailCategoryFooter.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 10.08.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import RealmSwift
class DetailCategoryFooter: UITableViewHeaderFooterView {
    
    static let identifier = "DetailCategoryFooter"
    
    let dateLabel = UILabel()
    let amountLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.font = UIFont(name: "system", size: 25)
        dateLabel.textColor = .gray
        
        amountLabel.font = UIFont(name: "system", size: 18)
        amountLabel.textAlignment = .right
        contentView.addSubview(dateLabel)
        contentView.addSubview(amountLabel)
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 150),
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            amountLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 20)
        ])
    }
    
    func setupAmountLabelForCategory(moneyActions: [MoneyAction], categoryType: CategoriesType) {
        var sum = 0.0
        switch categoryType {
       
        case .moneyCategory:
            moneyActions.forEach { action in
                sum += action is Income ? action.moneyCount : -action.moneyCount
            }
            amountLabel.textColor = sum >= 0 ? .systemGreen : .systemRed
        case .purchasesCategory:
            moneyActions.forEach { action in
                           sum += action.moneyCount
                       }
                       amountLabel.textColor = .systemRed
        }
        amountLabel.text = sum.formatToShow()
        guard let date = moneyActions.first?.date else { return }
        dateLabel.text = DateManager.shared.formatDateToStringDetailHeader(date: date)
        
//        if categoryType {
//            moneyActions.forEach { action in
//                sum += action is Income ? action.moneyCount : -action.moneyCount
//            }
//            amountLabel.textColor = sum >= 0 ? .systemGreen : .systemRed
//        } else {
//            moneyActions.forEach { action in
//                sum += action.moneyCount
//            }
//            amountLabel.textColor = .systemRed
//        }
        
        
    }
    
    func setupAmountLabelForAllCategories(moneyActions: [MoneyAction], categoryType: CategoriesType) {
        var sum = 0.0
        switch categoryType {
        case .moneyCategory:
            moneyActions.forEach { action in
                sum += action is Income ? action.moneyCount : -action.moneyCount
            }
            amountLabel.textColor = sum >= 0 ? .systemGreen : .systemRed
        case .purchasesCategory:
            moneyActions.forEach { action in
                sum += action.moneyCount
            }
            amountLabel.textColor = .systemRed
        }
        amountLabel.text = sum.formatToShow()
    }
}
