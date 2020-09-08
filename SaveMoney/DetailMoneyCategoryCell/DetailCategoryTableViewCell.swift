//
//  DetailCategoryTableViewCell.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 10.08.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import RealmSwift

class DetailCategoryTableViewCell: UITableViewCell {
    
    static let identifier = "DetailCategoryTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "DetailCategoryTableViewCell",
                     bundle: nil)
    }
    
    @IBOutlet var colorView: UIView!
    @IBOutlet var categoryImageView: UIImageView!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var nameActionLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        colorView.layer.cornerRadius = colorView.frame.width/2
    }
    
    func setupCellForMoneyCategory(action: MoneyAction) {
        nameActionLabel.text = action.name
        if let income = action as? Income  {
            amountLabel.textColor = .systemGreen
            amountLabel.text = "+ \(income.moneyCount.formatToShow())"
            colorView.backgroundColor = .systemYellow
            guard let categoryName = income.moneyCategory.first?.iconName else { return }
            categoryImageView.image = UIImage(named: categoryName)
            print(categoryName)
        } else if let purchases = action as? Purchases{
            amountLabel.textColor = .systemRed
            colorView.backgroundColor = .systemGreen
            amountLabel.text = "- \(purchases.moneyCount.formatToShow())"
            guard let categoryName = purchases.purchasesCategory.first?.iconName else { return }
            categoryImageView.image = UIImage(named: categoryName)
        }
    }
    
    func setupCellForPurchasesCategory(action: MoneyAction) {
        guard let purchases = action as? Purchases else { return }
        nameActionLabel.text = purchases.name
        amountLabel.textColor = .systemRed
        amountLabel.text = "\(purchases.moneyCount.formatToShow())"
        guard let categoryName = purchases.purchasesCategory.first?.iconName else { return }
        categoryImageView.image = UIImage(named: categoryName)
    }
}
