//
//  ViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 24.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private let addMoneyCategoryCellIdentifier = "addMoneyCategoryCellIdentifier"
   
    
    //MARK : - IB Outlets
    @IBOutlet var moneyCategoryCollectionView: UICollectionView!
    @IBOutlet var navigationBar: MainNavigationBar!
    @IBOutlet var purchasesCategoryCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.delegat = self
        moneyCategoryCollectionView.register(MoneyCategoryCollectionViewCell.nib(),
                                             forCellWithReuseIdentifier: MoneyCategoryCollectionViewCell.identifier)
        moneyCategoryCollectionView.delegate = self
        moneyCategoryCollectionView.dataSource = self
        purchasesCategoryCollectionView.register(PurchasesCategoryCollectionViewCell.nib(),
                                                 forCellWithReuseIdentifier: PurchasesCategoryCollectionViewCell.identifier)
    }
}
//MARK: - MainNavigationBarDelegate
extension MainViewController: MainNavigationBarDelegate {
    func watchBalance() {
        print("watchBalanceStatistic")
    }
    func watchExpense() {
        print("watchExpenseStatistic")
    }
    func watchPlan() {
        print("watchPlan")
    }
    func addMoney() {
        print("addMoney")
    }
    func showMenu() {
        print("showMenu")
        
    }
}

//MARK : - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
}

//MARK : - UICollectionFlowDelegate
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (moneyCategoryCollectionView.bounds.width - 30)/3, height: (moneyCategoryCollectionView.bounds.width - 30)/3)
    }
}
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  collectionView == purchasesCategoryCollectionView ? DataManager.shared.purchasesCategory.count + 1 : DataManager.shared.moneyCategoryes.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item ==  DataManager.shared.moneyCategoryes.count && collectionView == moneyCategoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifire.addMoneyCategoryCellIdentifier.rawValue,                                               for: indexPath)
            return cell
        }
        
        if indexPath.item == DataManager.shared.purchasesCategory.count && collectionView == purchasesCategoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifire.addPurchasesCategoryCollectionView.rawValue,                                           for: indexPath)
            return cell
        }
        
        if collectionView == purchasesCategoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PurchasesCategoryCollectionViewCell.identifier, for: indexPath) as! PurchasesCategoryCollectionViewCell
            cell.setupCell(image: UIImage(named: DataManager.shared.purchasesCategory[indexPath.item].nameForImage),                                  nameCategory: DataManager.shared.purchasesCategory[indexPath.item].typeOfPurchases.rawValue,
                           valute: DataManager.shared.purchasesCategory[indexPath.item].valute)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoneyCategoryCollectionViewCell.identifier, for: indexPath) as! MoneyCategoryCollectionViewCell
        cell.setupCell(image: UIImage(named: DataManager.shared.moneyCategoryes[indexPath.item].categoryType.rawValue),                               nameCategory: DataManager.shared.moneyCategoryes[indexPath.item].categoryType.rawValue,
                       valute: DataManager.shared.moneyCategoryes[indexPath.item].valute)
        return cell
    }
    
}


enum cellIdentifire: String {
    case addMoneyCategoryCellIdentifier
    case addPurchasesCategoryCollectionView
}


