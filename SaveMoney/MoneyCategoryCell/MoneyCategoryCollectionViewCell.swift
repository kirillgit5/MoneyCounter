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
    
    // MARK : - Override Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        colorView.layer.cornerRadius = colorView.frame.width/2
    }
    
    //MARK : - Public Methods
    func setupCell(moneyCategory: MoneyCategory) {
        nameCategoryLabel.text = moneyCategory.name
        moneyCountLabel.text = "\(moneyCategory.moneyCount) ₽"
        categoryImageView.image = UIImage(named: moneyCategory.name) ?? UIImage(named: "default")!
    }
}
