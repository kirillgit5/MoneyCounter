//
//  ViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 24.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import RealmSwift
class MainViewController: UIViewController {
    
   // MARK: - Private Property
    var moneyCategories: Results<MoneyCategory>!
    var purchasesCategories: Results<PurchasesCategory>!
    
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
        purchasesCategoryCollectionView.delegate = self
        purchasesCategoryCollectionView.dataSource = self
        purchasesCategoryCollectionView.register(PurchasesCategoryCollectionViewCell.nib(),
                                                 forCellWithReuseIdentifier: PurchasesCategoryCollectionViewCell.identifier)
        moneyCategories = StorageManager.shared.realm.objects(MoneyCategory.self)
        purchasesCategories = StorageManager.shared.realm.objects(PurchasesCategory.self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationBar.setBalance(moneyCatigories: moneyCategories)
        navigationBar.setExpense(purchasesCatigories: purchasesCategories)
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
        return collectionView === moneyCategoryCollectionView ? moneyCategories.count : purchasesCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === moneyCategoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoneyCategoryCollectionViewCell.identifier,
                                                          for: indexPath) as! MoneyCategoryCollectionViewCell
            cell.setupCell(moneyCategory: moneyCategories[indexPath.item])
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PurchasesCategoryCollectionViewCell.identifier,
                                                          for: indexPath) as! PurchasesCategoryCollectionViewCell
            cell.setupCell(purchasesCategory: purchasesCategories[indexPath.item])
            return cell
        }
    }
}


enum cellIdentifire: String {
    case addMoneyCategoryCellIdentifier
    case addPurchasesCategoryCollectionView
}


