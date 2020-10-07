//
//  BetaMoneyCategoryCollectionViewCell.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 09.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class BetaMoneyCategoryCollectionViewCell: UICollectionViewCell {

    static let identifier = "BetaMoneyCategoryCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "BetaMoneyCategoryCollectionViewCell",
                     bundle: nil)
    }
    
    var viewModel: MoneyCategoryCollectionViewCellViewModelProtocol! {
        didSet {
            nameCategoryLabel.text = viewModel.getCategoryName()
            moneyCountLabel.text = viewModel.getMoneyCount()
            categoryImageView.image = UIImage(named: viewModel.getImageName())
            moneyCountLabel.textColor = viewModel.isMoneyCountFewerThenZero() ? .systemRed : .systemOrange
            if viewModel.getIsAddItem() {
                setupConstraintsForAddItem()
            }
        }
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

    func startAnimation() {
        if !viewModel.getIsAddItem() {
        let shakeAnimation = CABasicAnimation(keyPath: "transform.rotation")
        shakeAnimation.autoreverses = true
        shakeAnimation.duration = 0.18
        shakeAnimation.repeatCount = .infinity
        
        let startAngle: Float = (-2) * 3.14159/180
        let stopAngle = -startAngle
        
        shakeAnimation.fromValue = NSNumber(value: startAngle)
        shakeAnimation.toValue = NSNumber(value: 3 * stopAngle)
//        shakeAnimation.timeOffset = 290 * drand48()
        
        self.layer.add(shakeAnimation, forKey: "animate")
        }
    }
    
    func setupConstraintsForAddItem() {
        colorView.backgroundColor = .white
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryImageView.topAnchor.constraint(equalTo: colorView.topAnchor),
            categoryImageView.leadingAnchor.constraint(equalTo: colorView.leadingAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: colorView.trailingAnchor),
            categoryImageView.bottomAnchor.constraint(equalTo: colorView.bottomAnchor)
        ])
    }
    
    
}
