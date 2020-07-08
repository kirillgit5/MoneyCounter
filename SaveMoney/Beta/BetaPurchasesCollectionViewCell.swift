//
//  BetaPurchasesCellCollectionViewCell.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 07.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class BetaPurchasesCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "BetaPurchasesCollectionViewCell"
    
    // MARK: - Public Propertyes
    let purchasesImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(purchasesImage)
        purchasesImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        purchasesImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        purchasesImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        purchasesImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
