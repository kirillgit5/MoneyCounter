//
//  ChooseIconCollectionViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 18.08.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

protocol ChooseIconDelegate {
    func addIconName(name: String)
}


class ChooseIconCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Public Property
    var categoryType: CategoriesType!
    var delegate: ChooseIconDelegate?
    //MARK: - Private Methods
    private let iconNames = DataManager.shared.iconNames
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(IconCollectionViewCell.nib(), forCellWithReuseIdentifier: IconCollectionViewCell.identifier)
        switch categoryType {
        case .moneyCategory:
            collectionView.backgroundColor = .systemYellow
        case .purchasesCategory:
            collectionView.backgroundColor = .systemGreen
        case .none:
            break
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconNames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IconCollectionViewCell.identifier, for: indexPath) as! IconCollectionViewCell
        cell.iconImageView.image = UIImage(named: iconNames[indexPath.item])
        switch categoryType {
        case .purchasesCategory:
            cell.mainView.backgroundColor = UIColor(red: 100/255, green: 220/255, blue: 140/255, alpha: 1.0)
        case .moneyCategory:
            cell.mainView.backgroundColor = UIColor(red: 240/255, green: 170/255, blue: 0/255, alpha: 1.0)
        case .none:
            break
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.addIconName(name: iconNames[indexPath.item])
        dismiss(animated: true)
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.width - 30)/6, height: (collectionView.frame.width - 30)/6)
    }
    
}
