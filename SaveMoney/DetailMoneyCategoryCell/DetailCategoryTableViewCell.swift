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
        if action is Income {
            amountLabel.textColor = .systemGreen
            categoryImageView.image = UIImage(named: "purse")
            amountLabel.text = "+ \(action.moneyCount.toString()) ₽"
            colorView.backgroundColor = .systemYellow
        } else {
            guard let action = action as? Purchases, let categoryName = action.purchasesCategory.first?.name else { return }
            amountLabel.textColor = .systemRed
            colorView.backgroundColor = .systemGreen
            categoryImageView.image = UIImage(named: categoryName)
            amountLabel.text = "- \(action.moneyCount.toString()) ₽"
        }
    }
}
