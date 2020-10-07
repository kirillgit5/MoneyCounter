//
//  AddIncomeViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 09.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class AddIncomeViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var navigationBar: AddMoneyActionNavigationBar!
    @IBOutlet var collectionView: UICollectionView!
    
    //MARK: - Public Property
    var viewModel: AddIncomeViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(BetaMoneyCategoryCollectionViewCell.nib(), forCellWithReuseIdentifier: BetaMoneyCategoryCollectionViewCell.identifier)
        infoLabel.text = viewModel.getInfoText()
        navigationBar.title.text = viewModel.getNavigationBarTitile()
        navigationBar.delegat = self
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
    
    private func setupNavigationBar() {
        navigationBar.title.text = viewModel.getNavigationBarTitile()
        infoLabel.text = viewModel.getInfoText()
    }
    
    
}

//MARK: CollectionViewDelegate
extension AddIncomeViewController  : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.selectItem(at: indexPath)
        let viewModelForSegue = viewModel.viewModelForCreateVC()
        performSegue(withIdentifier: SegueIndentifire.createIncome.rawValue, sender: viewModelForSegue)
    }
}

//MARK: CollectionViewDataSourse
extension AddIncomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BetaMoneyCategoryCollectionViewCell.identifier, for: indexPath) as! BetaMoneyCategoryCollectionViewCell
        cell.viewModel = viewModel.cellViewModal(for: indexPath)
        return cell
    }
    
}

// MARK: - CollectionViewDelegateFlowLayout
extension AddIncomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 30)/3, height: (collectionView.bounds.width  - 30)/3)
    }
}

extension AddIncomeViewController: AddMoneyActionNavigationBarDelegate {
    func back() {
        dismiss(animated: true)
    }
    
    func createMoneyAction() {
        showAlert()
    }
    
    
}
