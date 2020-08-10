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
        purchasesCategoryCollectionView.register(MoneyCategoryCollectionViewCell.nib(),
                                                 forCellWithReuseIdentifier: MoneyCategoryCollectionViewCell.identifier)
        moneyCategories = StorageManager.shared.realm.objects(MoneyCategory.self)
        purchasesCategories = StorageManager.shared.realm.objects(PurchasesCategory.self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moneyCategoryCollectionView.reloadData()
        purchasesCategoryCollectionView.reloadData()
        navigationBar.setBalance(moneyCatigories: moneyCategories)
        navigationBar.setExpense(purchasesCatigories: purchasesCategories)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIndentifire.addMoneyAction.rawValue {
            guard let navController = segue.destination as? UINavigationController else { return }
            guard let addVC = navController.topViewController as? AddMoneyActionViewController else { return }
            if let moneyCategory = sender as?  [MoneyCategory] {
                addVC.categories = moneyCategory
            } else {
                addVC.categories = sender as! [PurchasesCategory]
            }
            
        }
        if segue.identifier == segueIndentifire.showDetailCategory.rawValue {
            guard let collectionView = sender as? UICollectionView else { return }
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            let navController = segue.destination as! UINavigationController
            let detailCategoryVC = navController.topViewController as! DetailCategoryTableViewController
            if collectionView === moneyCategoryCollectionView {
                detailCategoryVC.category = moneyCategories[indexPath.item]
            } else {
                detailCategoryVC.category = purchasesCategories[indexPath.item]
            }
            
        }
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
        performSegue(withIdentifier: segueIndentifire.addMoneyAction.rawValue, sender:Array(moneyCategories))
    }
    func addExpense() {
        performSegue(withIdentifier: segueIndentifire.addMoneyAction.rawValue , sender: Array(purchasesCategories))
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == moneyCategoryCollectionView {
            performSegue(withIdentifier: segueIndentifire.showDetailCategory.rawValue, sender: moneyCategoryCollectionView)
        } else {
            performSegue(withIdentifier: segueIndentifire.showDetailCategory.rawValue, sender: purchasesCategoryCollectionView)
        }
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
            cell.setupCell(category: moneyCategories[indexPath.item])
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoneyCategoryCollectionViewCell.identifier,
                                                          for: indexPath) as! MoneyCategoryCollectionViewCell
            cell.setupCell(category: purchasesCategories[indexPath.item])
            return cell
        }
    }
}




