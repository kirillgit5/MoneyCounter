//
//  ViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 24.06.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import RealmSwift
class MainMenuViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var moneyCategoryCollectionView: UICollectionView!
    @IBOutlet var navigationBar: MainNavigationBar!
    @IBOutlet var purchasesCategoryCollectionView: UICollectionView!
    @IBOutlet var collectionsView: UIView!
    
    // MARK: - Private Property
    private let viewModel = MainMenuViewModel()
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.delegat = self
        moneyCategoryCollectionView.register(BetaMoneyCategoryCollectionViewCell.nib(),
                                             forCellWithReuseIdentifier: BetaMoneyCategoryCollectionViewCell.identifier)
        moneyCategoryCollectionView.delegate = self
        moneyCategoryCollectionView.dataSource = self
        purchasesCategoryCollectionView.delegate = self
        purchasesCategoryCollectionView.dataSource = self
        purchasesCategoryCollectionView.register(PurchasesCategoryCollectionViewCell.nib(),
                                                 forCellWithReuseIdentifier: PurchasesCategoryCollectionViewCell.identifier)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moneyCategoryCollectionView.reloadData()
        purchasesCategoryCollectionView.reloadData()
        navigationBar.setBalance(balance: viewModel.getBalance())
        navigationBar.setExpense(expense: viewModel.getExpense())
        navigationBar.setTaskCount(tasksCount: viewModel.getTaskCount())
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIndentifire.addIncome.rawValue {
            guard let viewModel = sender as? AddIncomeViewModelProtocol else { return }
            guard let navController = segue.destination as? UINavigationController else { return }
            guard let vc = navController.topViewController as? AddIncomeViewController else { return }
            vc.viewModel = viewModel
            
        } else if segue.identifier == SegueIndentifire.addPurchases.rawValue {
            guard let viewModel = sender as? AddPurshaeseViewModelProtocol else { return }
            guard let navController = segue.destination as? UINavigationController else { return }
            guard let vc = navController.topViewController as? AddPurshasesViewController else { return }
            vc.viewModel = viewModel
            
        } else  if segue.identifier == SegueIndentifire.detailAllCategories.rawValue {
            guard let categoryType = sender as? CategoriesType else { return }
            guard let navController = segue.destination as? UINavigationController else { return }
            guard let addVC = navController.topViewController as? DetailAllCategoriesTableViewController else { return }
            addVC.categoriesType = categoryType
            
        } else if segue.identifier == SegueIndentifire.showDetailCategory.rawValue {
            let navController = segue.destination as! UINavigationController
            let detailCategoryVC = navController.topViewController as! DetailCategoryTableViewController
            guard let viewModelForVC = sender as? DetailCategoryViewModelProtocol else { return }
            detailCategoryVC.viewModel = viewModelForVC
            
        } else if segue.identifier == SegueIndentifire.addCategory.rawValue {
            guard let collectionView = sender as? UICollectionView else { return }
            let createCategoryVC = segue.destination as! CreateCategoryViewController
            if collectionView === moneyCategoryCollectionView {
                createCategoryVC.categoriesType  = .moneyCategory
            } else {
                createCategoryVC.categoriesType = .purchasesCategory
            }
        } else if segue.identifier == SegueIndentifire.showTaskList.rawValue {
            guard let navController = segue.destination as? UINavigationController else { return }
            guard let taskListVC = navController.topViewController as? TaskListTableViewController else { return }
            guard let taskList = sender as? Results<Task> else { return }
            taskListVC.taskLists = taskList
        }
    }
    
}

//MARK: - MainNavigationBarDelegate
extension MainMenuViewController: MainNavigationBarDelegate {
    func watchBalance() {
        performSegue(withIdentifier: SegueIndentifire.detailAllCategories.rawValue, sender: CategoriesType.moneyCategory)
    }
    func watchExpense() {
        performSegue(withIdentifier: SegueIndentifire.detailAllCategories.rawValue, sender: CategoriesType.purchasesCategory)
    }
    func watchPlan() {
        performSegue(withIdentifier: SegueIndentifire.showTaskList.rawValue, sender: viewModel.getTaskList())
    }
    func addMoney() {
        let incomeViewModel = viewModel.getAddIncomeViewModel()
        performSegue(withIdentifier: SegueIndentifire.addIncome.rawValue, sender: incomeViewModel)
    }
    func addExpense() {
        let purchasesViewModel = viewModel.getAddPurshasesViewModel()
        performSegue(withIdentifier: SegueIndentifire.addPurchases.rawValue , sender: purchasesViewModel)
    }
    
    
}


//MARK: - UICollectionFlowDelegate
extension MainMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (moneyCategoryCollectionView.bounds.width - 30)/3, height: (moneyCategoryCollectionView.bounds.width - 30)/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        if collectionView == moneyCategoryCollectionView {
            if indexPath.row < viewModel.getMoneyCategoriesCount() {
                let viewModelForSegue = viewModel.viewModelForDetailMoneyActions(at: indexPath, collectionType: CategoriesType.moneyCategory)
                performSegue(withIdentifier: SegueIndentifire.showDetailCategory.rawValue, sender: viewModelForSegue)
            } else {
                performSegue(withIdentifier: SegueIndentifire.addCategory.rawValue, sender: moneyCategoryCollectionView)
            }
        } else {
            if indexPath.row < viewModel.getPurshasesCategoryCount() {
                let viewModelForSegue = viewModel.viewModelForDetailMoneyActions(at: indexPath, collectionType: CategoriesType.purchasesCategory)
                performSegue(withIdentifier: SegueIndentifire.showDetailCategory.rawValue, sender: viewModelForSegue)
            } else {
                performSegue(withIdentifier: SegueIndentifire.addCategory.rawValue, sender: purchasesCategoryCollectionView)
            }
        }
        
    }
    
    
}

//MARK: - extension UICollectionViewDataSource
extension MainMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let collectionType  = collectionView === moneyCategoryCollectionView ? CategoriesType.moneyCategory : CategoriesType.purchasesCategory
        return viewModel.numberOfItems(collectionType: collectionType)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView === moneyCategoryCollectionView {
            if indexPath.row < viewModel.getMoneyCategoriesCount() {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BetaMoneyCategoryCollectionViewCell.identifier,
                                                              for: indexPath) as! BetaMoneyCategoryCollectionViewCell
                cell.viewModel = viewModel.cellMoneyCategoryViewModal(for: indexPath)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.getAddMoneyCategoryCellIdentifire(), for: indexPath)
                return cell
            }
        } else {
            if indexPath.row < viewModel.getPurshasesCategoryCount() {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PurchasesCategoryCollectionViewCell.identifier,
                                                              for: indexPath) as! PurchasesCategoryCollectionViewCell
                cell.viewModel = viewModel.cellViewModelPurchasesCategory(for: indexPath)
                
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.getAddPurchasesCategoryCellIdentifire(), for: indexPath)
                return cell
            }
        }
    }
}








