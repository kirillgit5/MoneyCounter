//
//  AddMoneyActionViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 16.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class AddPurshasesViewController: UIViewController {
    
    //MARK : IB Outlets
    @IBOutlet var navigationBar: AddMoneyActionNavigationBar!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var categoryCollectionView: UICollectionView!
    
    // MARK : - Pubic Properties
    var viewModel: AddPurshaeseViewModelProtocol!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryCollectionView.register(PurchasesCategoryCollectionViewCell.nib(),
                                             forCellWithReuseIdentifier: PurchasesCategoryCollectionViewCell.identifier)
        navigationBar.delegat = self
        setupNavigationBar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let chooseMCViewModel = sender as? ChooseMoneyCategoryViewModel else { return }
        let chooseVC = segue.destination as! ChooseMoneyCategoryCollectionViewController
        chooseVC.viewModel = chooseMCViewModel
    }
    
    
    // MARK : - Private Method
    private func setupNavigationBar() {
        navigationBar.title.text = viewModel.getNavigationBarTitile()
        infoLabel.text = viewModel.getInfoText()
    }
    private func showAlert(){
        let message = "Выберите категорию расхода"
        let alert = UIAlertController(title: "Внимание",
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert,animated: true)
    }
}

//MARK : CollectionViewDataSourse
extension AddPurshasesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         viewModel.numberOfItems()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PurchasesCategoryCollectionViewCell.identifier ,
                                                      for: indexPath) as! PurchasesCategoryCollectionViewCell
        
        cell.viewModel = viewModel.cellViewModal(for: indexPath)
        return cell
    }
    
}

//MARK : CollectionViewDelegate
extension AddPurshasesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.selectItem(at: indexPath)
        let chooseMCViewModel = viewModel.viewModelForSelectedRow()
        performSegue(withIdentifier: SegueIndentifire.chooseMoneyCategory.rawValue, sender: chooseMCViewModel)
    }
}


//MARK : CollectionViewDelegateFlowLayout
extension AddPurshasesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 30)/3, height: (collectionView.bounds.width  - 30)/3)
    }
}

extension AddPurshasesViewController: AddMoneyActionNavigationBarDelegate {
    func back() {
        dismiss(animated: true)
    }
    
    func createMoneyAction() {
        showAlert()
    }
}
