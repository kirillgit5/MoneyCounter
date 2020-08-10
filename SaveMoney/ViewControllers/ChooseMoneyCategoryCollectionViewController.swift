//
//  ChooseMoneyCategoryCollectionViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 19.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import RealmSwift
class ChooseMoneyCategoryCollectionViewController: UIViewController {
    
    @IBOutlet var navigationBar: AddMoneyActionNavigationBar!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var categoryCollectionView: UICollectionView!
    // MARK : Private Property
    var purchaseCategory: PurchasesCategory!
    var moneyCategories: Results<MoneyCategory>!
    
    // MARL : Override Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.register(MoneyCategoryCollectionViewCell.nib(), forCellWithReuseIdentifier: MoneyCategoryCollectionViewCell.identifier)
        moneyCategories = StorageManager.shared.realm.objects(MoneyCategory.self)
        infoLabel.text = "Выберите счет"
        navigationBar.title.text = "Добавление расхода"
        navigationBar.delegat = self
        navigationBar.setupNavBarSecondType()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = categoryCollectionView.indexPathsForSelectedItems?.first else { return }
        let createVC = segue.destination as! CreateMoneyActionViewController
        createVC.categoryForAdd = purchaseCategory
        createVC.categoryForBuy = moneyCategories[indexPath.item]
    }
    
    //MARK: Private Methods
    private func showAlert(){
        let message = "Выберите счет"
        let alert = UIAlertController(title: "Внимание",
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert,animated: true)
    }
    
}

// MARK : CollectionViewDelegate
extension ChooseMoneyCategoryCollectionViewController  : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueIndentifire.createPurchases.rawValue, sender: nil)
    }
}

// MARK : CollectionViewDataSourse
extension ChooseMoneyCategoryCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        moneyCategories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoneyCategoryCollectionViewCell.identifier, for: indexPath) as! MoneyCategoryCollectionViewCell
        cell.setupForChooseMoneyVC(moneyCategory: moneyCategories[indexPath.item])
        return cell
    }
    
}
// MARK : CollectionViewDelegateFlowLayout
extension ChooseMoneyCategoryCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 30)/3, height: (collectionView.bounds.width  - 30)/3)
    }
}

extension ChooseMoneyCategoryCollectionViewController: AddMoneyActionNavigationBarDelegate{
    func addMoneyCategory() {
        showAlert()
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
}
