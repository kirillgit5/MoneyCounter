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
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var categoryImageView: UIImageView!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var nameActionLabel: UILabel!
    
    func setCell(action: MoneyAction) {
        nameActionLabel.text = action.name
        amountLabel.text = "\(action.moneyCount)"
        if action is Income {
            amountLabel.textColor = .green
            categoryImageView.image = UIImage(named: "purse")
        } else {
            guard let action = action as? Purchases, let categoryName = action.purchasesCategory.first?.name else { return }
            amountLabel.textColor = .systemRed
            categoryImageView.image = UIImage(named: categoryName)
        }
    }
    
}
