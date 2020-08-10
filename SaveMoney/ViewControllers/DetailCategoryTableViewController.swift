//
//  DetailMoneyCategoryTableViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 13.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import RealmSwift
class DetailCategoryTableViewController: UITableViewController {
    
    // MARK : - Public Property
    var category: Category!
    
    // MARK : Private Property
    private var sortedMoneyAction : [[MoneyAction]] {
        if let moneyCategory = category as? MoneyCategory {
            return SortManager.shared.sortIncomesByDate(incomes: moneyCategory.incomes)
        } else if let  purchasesCategory = category as? PurchasesCategory {
            return SortManager.shared.sortPurshasesByDate(purshase: purchasesCategory.purchases)
        }
        return [[MoneyAction]]()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    //MARK : - Private Methods
    private func setupNavigationBar() {
        title = category.name
        navigationController?.navigationBar.prefersLargeTitles = true
        let navBarApperance = UINavigationBarAppearance()
        navBarApperance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarApperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarApperance.configureWithOpaqueBackground()
        navBarApperance.backgroundColor = category is MoneyCategory ? UIColor(red: 210/255,
                                                                              green: 160/255,
                                                                              blue: 0/255,
                                                                              alpha: 194/255) : UIColor(red: 0/255,
                                                                                                        green: 210/255,
                                                                                                        blue: 100/255,
                                                                                                        alpha: 194/255)
        navigationController?.navigationBar.standardAppearance = navBarApperance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarApperance
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(back))
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK : Selector
    @objc func back() {
        dismiss(animated: true)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        sortedMoneyAction.count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(sortedMoneyAction[section].count)
       return sortedMoneyAction[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
}
