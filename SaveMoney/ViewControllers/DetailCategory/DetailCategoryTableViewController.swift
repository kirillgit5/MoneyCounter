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
    
    // MARK: - Private Property
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
    
    var viewModel: DetailCategoryViewModelProtocol!
    private var newIndexPath: IndexPath?
    private var changeMoneyActionType = ChangeMoneyActionType.noAction
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        reloadData()
        tableView.register(DetailCategoryFooter.self, forHeaderFooterViewReuseIdentifier: DetailCategoryFooter.identifier)
        if viewModel.isMoneyCategory() {
            tableView.register(DetailCategoryTableViewCell.nib(), forCellReuseIdentifier: DetailCategoryTableViewCell.identifier)
        } else {
            tableView.register(DetailPurchasesTableViewCell.nib(), forCellReuseIdentifier: DetailPurchasesTableViewCell.identifier)
        }
        
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
        let createVC = segue.destination as! EditMoneyActionViewController
        createVC.viewModel = sender as? EditMoneyActionViewModelProtocol
        createVC.updateTableViewDelegate = self
        
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        sortedMoneyAction.count
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortedMoneyAction[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isMoneyCategory() {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailCategoryTableViewCell.identifier, for: indexPath) as! DetailCategoryTableViewCell
            cell.setupCellForMoneyCategory(action: sortedMoneyAction[indexPath.section][indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailPurchasesTableViewCell.identifier, for: indexPath) as! DetailPurchasesTableViewCell
            cell.viewModel = DetailPurchasesTableViewCellViewModel(moneyAction: sortedMoneyAction[indexPath.section][indexPath.row])
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
    
    override func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int) -> UIView? {
        let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier:
            DetailCategoryFooter.identifier) as! DetailCategoryFooter
        footer.setupAmountLabelForCategory(moneyActions: sortedMoneyAction[section], categoryType: viewModel.getCategoryType())
        return footer
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, _) in
            guard let self = self else { return }
            self.sortedMoneyAction[indexPath.section].remove(at: indexPath.row)
            if self.sortedMoneyAction[indexPath.section].isEmpty {
                self.sortedMoneyAction.remove(at: indexPath.section)
                let indexSet = IndexSet(arrayLiteral: indexPath.section)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModelForSegue = EditMoneyActionViewModel(editMoneyAction: sortedMoneyAction[indexPath.section][indexPath.row])
        editIndexPath = indexPath
        performSegue(withIdentifier: SegueIndentifire.editMoneyAction.rawValue, sender: viewModelForSegue)
    }
    
    //MARK: - Private Methods
    private func setupNavigationBar() {
        title = viewModel.getName()
        navigationController?.navigationBar.prefersLargeTitles = true
        let navBarApperance = UINavigationBarAppearance()
        navBarApperance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarApperance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarApperance.backgroundColor = viewModel.isMoneyCategory() ? .systemYellow : .systemGreen
        navigationController?.navigationBar.standardAppearance = navBarApperance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarApperance
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(back))
        navigationController?.navigationBar.tintColor = .white
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
        sortedMoneyAction = viewModel.getMoneyActions()
        tableView.reloadData()
    }
    // MARK: - Selector
    @objc func back() {
        dismiss(animated: true)
    }
    
    deinit {
        print()
    }
}


//MARK: - Extension UpdateTableViewDateDelegate
extension DetailCategoryTableViewController: UpdateTableViewDateDelegate {
    
    func changeIndexPath(date: Date) {
        guard  let indexPath = editIndexPath else { return }
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


