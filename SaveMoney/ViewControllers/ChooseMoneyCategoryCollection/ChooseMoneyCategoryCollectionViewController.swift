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
    
    //MARK: Private Property
    var viewModel: ChooseMoneyCategoryViewModelProtocol!
    
    //MARK: - Override Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCollectionView.register(BetaMoneyCategoryCollectionViewCell.nib(), forCellWithReuseIdentifier: BetaMoneyCategoryCollectionViewCell.identifier)
        infoLabel.text = viewModel.getInfoText()
        navigationBar.title.text = viewModel.getNavigationBarTitle()
        navigationBar.delegat = self
        navigationBar.setupNavBarSecondType()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewModelForSegue = sender as? CreateMoneyActionViewModelProtocol else { return }
        let createVC = segue.destination as! CreateMoneyActionViewController
        createVC.viewModel = viewModelForSegue
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

// MARK: - CollectionViewDelegate
extension ChooseMoneyCategoryCollectionViewController  : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.selectItem(at: indexPath)
        let viewModelForSegue = viewModel.viewModelForCreateVC()
        performSegue(withIdentifier: SegueIndentifire.createPurchases.rawValue, sender: viewModelForSegue)
    }
}

// MARK: - CollectionViewDataSourse
extension ChooseMoneyCategoryCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BetaMoneyCategoryCollectionViewCell.identifier, for: indexPath) as! BetaMoneyCategoryCollectionViewCell
        cell.viewModel = viewModel.cellViewModal(for: indexPath)
        return cell
    }
    
}
// MARK: - CollectionViewDelegateFlowLayout
extension ChooseMoneyCategoryCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 30)/3, height: (collectionView.bounds.width  - 30)/3)
    }
}

extension ChooseMoneyCategoryCollectionViewController: AddMoneyActionNavigationBarDelegate{
    func createMoneyAction() {
        showAlert()
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
}
