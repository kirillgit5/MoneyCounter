//
//  MoneyCategoryCollectionViewCell.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 25.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class MoneyCategoryCollectionViewCell: UICollectionViewCell {
    
    //MARK : - Static Property
    static let identifier = "MoneyCategoryCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MoneyCategoryCollectionViewCell",
                     bundle: nil)
    }
    
    //MARK: - IB Outlets
    @IBOutlet var colorView: UIView!
    @IBOutlet var categoryImageView: UIImageView!
    @IBOutlet var nameCategoryLabel: UILabel!
    @IBOutlet var moneyCountLabel: UILabel!
    @IBOutlet var mainView: UIView!
    
    // MARK : - Override Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        colorView.layer.cornerRadius = colorView.frame.width/2
    }
    
    //MARK : - Public Methods
    func setupCell(category: Category) {
        if let moneyCategory = category as? MoneyCategory {
        nameCategoryLabel.text = moneyCategory.name
            moneyCountLabel.text = moneyCategory.moneyCount.formatToShow()
        categoryImageView.image = UIImage(named: moneyCategory.iconName)
            if moneyCategory.moneyCount < 0 {
                moneyCountLabel.textColor = .systemRed
            } else {
                moneyCountLabel.textColor = .systemOrange
            }
        } else if let purchasesCategory = category as?  PurchasesCategory {
            nameCategoryLabel.text = purchasesCategory.name
            moneyCountLabel.text = purchasesCategory.moneyCount.formatToShow()
            categoryImageView.image = UIImage(named: purchasesCategory.iconName)
            mainView.backgroundColor = .white
            colorView.backgroundColor = .systemGreen
        }
    }
    
    func setupForAddMoneyCategoryViewController(category: Category) {
         nameCategoryLabel.text = category.name
         categoryImageView.image = UIImage(named: category.iconName)
         mainView.backgroundColor = .white
        colorView.backgroundColor = category is MoneyCategory ? UIColor.systemYellow : UIColor.systemGreen
    }
    
    func setupForChooseMoneyVC(moneyCategory: MoneyCategory) {
        nameCategoryLabel.text = moneyCategory.name
        categoryImageView.image = UIImage(named: moneyCategory.iconName) 
        mainView.backgroundColor = .white
        moneyCountLabel.text = moneyCategory.moneyCount.formatToShow()
        if moneyCategory.moneyCount < 0 {
            moneyCountLabel.textColor = .systemRed
        }
    }
}

