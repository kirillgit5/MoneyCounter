//
//  DetailAllCategoriesTableViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 16.08.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class DetailAllCategoriesTableViewController: UITableViewController {
    
    //MARK: - Public Property
    var categoriesType: CategoriesType!
    
    //MARK : Private Property
    private var sortedMoneyAction = [[MoneyAction]]()
    private var editIndexPath: IndexPath?
    
    private var allDates : [Date] {
        var dates = [Date]()
        sortedMoneyAction.forEach { actions in
            if  let action = actions.first {
                dates.append(action.date)
            }
        }
        return dates
    }
    
    private var newIndexPath: IndexPath?
    private var changeMoneyActionType = ChangeMoneyActionType.noAction
    
    //MARK: _ Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
        setupNavigationBar()
        tableView.register(DetailCategoryFooter.self, forHeaderFooterViewReuseIdentifier: DetailCategoryFooter.identifier)
        tableView.register(DetailCategoryTableViewCell.nib(), forCellReuseIdentifier: DetailCategoryTableViewCell.identifier)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let indexPath = editIndexPath else { return }
        let newDate = sortedMoneyAction[indexPath.section][indexPath.row].date
        let indexSetForOldSection = IndexSet(arrayLiteral: indexPath.section)
        
        switch changeMoneyActionType {
        case .moveSection:
            
            if let newSectionIndex = searchNewIndexForSection(date: newDate) {
                let action = sortedMoneyAction[indexPath.section]
                sortedMoneyAction.remove(at: indexPath.section)
                sortedMoneyAction.insert(action, at: newSectionIndex)
                let indexSet = IndexSet(arrayLiteral: newSectionIndex)
                tableView.moveSection(indexPath.section, toSection: newSectionIndex)
                tableView.beginUpdates()
                tableView.reloadSections(indexSet, with: .automatic)
                tableView.endUpdates()
            } else {
                reloadData()
            }
        case .moveRow:
            let action = sortedMoneyAction[indexPath.section][indexPath.row]
            sortedMoneyAction[indexPath.section].remove(at: indexPath.row)
            if var newIndexPath = searchNewIndexPathForRow(date: newDate) {
                sortedMoneyAction[newIndexPath.section].insert(action, at: newIndexPath.item)
                newIndexPath.item -= 1
                let indexSetForNewSection = IndexSet(arrayLiteral: newIndexPath.section)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                tableView.reloadSections(indexSetForNewSection, with: .automatic)
                tableView.reloadSections(indexSetForOldSection, with: .automatic)
                tableView.endUpdates()
            } else {
                reloadData()
            }
        case .removeSection:
            if  newIndexPath != nil  {
                let action = sortedMoneyAction[indexPath.section][indexPath.row]
                sortedMoneyAction[newIndexPath!.section].insert(action, at: newIndexPath!.row)
                sortedMoneyAction.remove(at: indexPath.section)
                newIndexPath!.item -= 1
                let indexSetForNewSection = IndexSet(arrayLiteral: newIndexPath!.section)
                tableView.beginUpdates()
                tableView.reloadSections(indexSetForNewSection, with: .automatic)
                tableView.deleteSections(indexSetForOldSection, with: .automatic)
                tableView.endUpdates()
                newIndexPath = nil
            } else {
                reloadData()
            }
            
        case .reloadSection:
            tableView.beginUpdates()
            tableView.reloadSections(indexSetForOldSection, with: .automatic)
            tableView.endUpdates()
            
        case .noAction:
            break
        case .createSection:
            let action = sortedMoneyAction[indexPath.section][indexPath.row]
            sortedMoneyAction[indexPath.section].remove(at: indexPath.row)
            if let index = searchNewIndexForSection(date: newDate) {
                sortedMoneyAction.insert([action], at: index)
                
                let indexSetForNewSection = IndexSet(arrayLiteral: index)
                let indexSetForOldSection = IndexSet(arrayLiteral: indexPath.section)
                
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.insertSections(indexSetForNewSection, with: .automatic)
                tableView.reloadSections(indexSetForOldSection, with: .automatic)
                tableView.endUpdates()
            } else {
                reloadData()
            }
        }
        changeMoneyActionType = .noAction
        editIndexPath = nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        editIndexPath = indexPath
        let createVC = segue.destination as! CreateMoneyActionViewController
//        createVC.editMoneyAction = sortedMoneyAction[indexPath.section][indexPath.row]
        createVC.updateTableViewDelegate = self
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIndentifire.editMoneyActionForAllCategories.rawValue, sender: nil)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        sortedMoneyAction.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortedMoneyAction[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailCategoryTableViewCell.identifier, for: indexPath) as! DetailCategoryTableViewCell
        switch categoriesType {
        case .moneyCategory:
            cell.setupCellForMoneyCategory(action: sortedMoneyAction[indexPath.section][indexPath.row])
        case .purchasesCategory:
            cell.setupCellForPurchasesCategory(action: sortedMoneyAction[indexPath.section][indexPath.row])
        case .none:
            break
        }
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, _) in
            guard let self = self else { return }
            StorageManager.shared.delete(action: self.sortedMoneyAction[indexPath.section][indexPath.row])
            self.sortedMoneyAction[indexPath.section].remove(at: indexPath.row)
            if self.sortedMoneyAction[indexPath.section].isEmpty {
                let indexSet = IndexSet(arrayLiteral: indexPath.section)
                self.sortedMoneyAction.remove(at: indexPath.section)
                tableView.beginUpdates()
                tableView.deleteSections(indexSet, with: .automatic)
                tableView.endUpdates()
            } else {
                let indexSet = IndexSet(arrayLiteral: indexPath.section)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadSections(indexSet, with: .automatic)
                tableView.endUpdates()
            }
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier:
            DetailCategoryFooter.identifier) as! DetailCategoryFooter
        footer.setupAmountLabelForAllCategories(moneyActions: sortedMoneyAction[section], categoryType: categoriesType)
        guard let date = sortedMoneyAction[section].first?.date else { return nil }
        footer.dateLabel.text = DateManager.shared.formatDateToStringDetailHeader(date: date)
        return footer
    }
    
    
    private func searchNewIndexForSection(date: Date) -> Int? {
        var dates = allDates
        dates.append(date)
        dates.sort{ $0 > $1 }
        guard let index = dates.firstIndex(of: date) else { return nil }
        return index
    }
    
    private func searchNewIndexForRow(date: Date) -> Int? {
        guard let indexPath = editIndexPath else { return nil }
        var dates = allDates
        dates.remove(at: indexPath.section)
        dates.append(date)
        dates.sort{ $0 > $1 }
        guard let index = dates.firstIndex(of: date) else { return nil }
        return index
    }
    
    private func searchNewIndexPathForRow(date: Date) -> IndexPath? {
        guard  let section = DateManager.shared.firstIndex(dates: allDates, date: date) else { return nil }
        var dates = sortedMoneyAction[section].map { $0.date }
        dates.append(date)
        dates.sort { $0 > $1 }
        guard let item = dates.firstIndex(of: date) else { return nil }
        return IndexPath(item: item, section: section)
    }
    
    private func reloadData() {
        switch categoriesType {
        case .moneyCategory:
            let moneyActions = Array(StorageManager.shared.realm.objects(MoneyCategory.self)).map { $0.allActions }.reduce([], +)
            sortedMoneyAction = SortManager.shared.sortMoneyActionsByDate(moneyActions: moneyActions)
        case .purchasesCategory:
            let purchasesActions = Array(StorageManager.shared.realm.objects(PurchasesCategory.self)).map { $0.purchases }.reduce([], +)
            sortedMoneyAction = SortManager.shared.sortMoneyActionsByDate(moneyActions: purchasesActions)
        case .none:
            break
        }
        tableView.reloadData()
    }
    
    //MARK : - Private Methods
    private func setupNavigationBar() {
        title = categoriesType == .moneyCategory ? "Все доходы" : "Все расходы"
        navigationController?.navigationBar.prefersLargeTitles = true
        let navBarApperance = UINavigationBarAppearance()
        navBarApperance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarApperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarApperance.backgroundColor = categoriesType == .moneyCategory ? .systemYellow : .systemGreen
        navigationController?.navigationBar.standardAppearance = navBarApperance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarApperance
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(back))
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func back() {
        dismiss(animated: true)
    }
}

extension DetailAllCategoriesTableViewController: UpdateTableViewDateDelegate {
    func changeIndexPath(date: Date) {
        guard let indexPath = editIndexPath else { return }
        if  !DateManager.shared.isEqualDates(firstDate: sortedMoneyAction[indexPath.section][indexPath.row].date, secondDate: date) && DateManager.shared.isDatesContainsDate(dates: allDates, date: date)  {
            changeMoneyActionType = sortedMoneyAction[indexPath.section].count == 1 ? .removeSection : .moveRow
            if changeMoneyActionType == .removeSection {
                newIndexPath = searchNewIndexPathForRow(date: date)
            }
        } else if sortedMoneyAction[indexPath.section].count == 1, let index = searchNewIndexForRow(date: date), index - indexPath.section != 0 {
            changeMoneyActionType = .moveSection
        } else if sortedMoneyAction[indexPath.section].count > 1 && !DateManager.shared.isEqualDates(firstDate: sortedMoneyAction[indexPath.section][indexPath.row].date, secondDate: date) {
            changeMoneyActionType = .createSection
        } else {
            changeMoneyActionType = .reloadSection
        }
    }
}
