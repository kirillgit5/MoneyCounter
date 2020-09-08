//
//  IconCollectionViewCell.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 19.08.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class IconCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet var iconImageView: UIImageView!
    static let identifier = "IconCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "IconCollectionViewCellIB",
                     bundle: nil)
    }

    //MARK: - Override Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        mainView.layer.cornerRadius = mainView.frame.width/2
    }
}
