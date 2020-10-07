//
//  AddMoneyActionViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 16.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class AddMoneyActionViewController: UIViewController {
    
    //MARK : IB Outlets
    @IBOutlet var navigationBar: AddMoneyActionNavigationBar!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var categoryCollectionView: UICollectionView!
    
    // MARK : - Pubic Properties
    var categories: [Category]!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryCollectionView.register(MoneyCategoryCollectionViewCell.nib(),
                                             forCellWithReuseIdentifier: MoneyCategoryCollectionViewCell.identifier)
        navigationBar.delegat = self
        setupNavigationBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIndentifire.createIncome.rawValue {
            guard let indexPath = categoryCollectionView.indexPathsForSelectedItems?.first else { return }
            let createVC = segue.destination as! CreateMoneyActionViewController
            createVC.categoryForAdd = categories[indexPath.item]
            
        } else {
            guard let indexPath = categoryCollectionView.indexPathsForSelectedItems?.first else { return }
            let chooseVC = segue.destination as! ChooseMoneyCategoryCollectionViewController
            chooseVC.purchaseCategory = categories[indexPath.item] as! PurchasesCategory
        }
    }
    
    
    // MARK : - Private Method
    private func setupNavigationBar() {
        navigationBar.title.text = categories is [MoneyCategory] ? "Добавление дохода" :  "Добавление расхода"
        infoLabel.text = categories is [MoneyCategory] ? "Выберите, куда пришли деньги" :  "Выберите категорию расхода"
    }
    private func showAlert(){
        let message = categories is [MoneyCategory] ? "Выберите счет" : "Выберите категорию расхода"
        let alert = UIAlertController(title: "Внимание",
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert,animated: true)
    }
}

//MARK : CollectionViewDataSourse
extension AddMoneyActionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoneyCategoryCollectionViewCell.identifier ,
                                                      for: indexPath) as! MoneyCategoryCollectionViewCell
        cell.setupForAddMoneyCategoryViewController(category: categories[indexPath.item])
        return cell
    }
    
}

//MARK : CollectionViewDelegate
extension AddMoneyActionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if categories[indexPath.item] is PurchasesCategory {
            performSegue(withIdentifier: SegueIndentifire.chooseMoneyCategory.rawValue, sender: nil)
            
        } else {
            performSegue(withIdentifier: SegueIndentifire.createIncome.rawValue, sender: nil)
        }
    }
}


//MARK : CollectionViewDelegateFlowLayout
extension AddMoneyActionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 30)/3, height: (collectionView.bounds.width  - 30)/3)
    }
}

extension AddMoneyActionViewController: AddMoneyActionNavigationBarDelegate {
    func back() {
        dismiss(animated: true)
    }
    
    func addMoneyCategory() {
        showAlert()
    }
}
