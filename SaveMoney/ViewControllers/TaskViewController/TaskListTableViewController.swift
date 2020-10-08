//
//  TaskListTableViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 07.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import RealmSwift

class TaskListTableViewController: UITableViewController {
    
    var taskLists: Results<Task>!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(back))
        taskLists = taskLists.sorted(byKeyPath: "name")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        
        let task = taskLists[indexPath.row]
        cell.textLabel?.text = task.name
        return cell
}
 // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let currentTask = taskLists[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            StorageManager.shared.delete(task: currentTask)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_, _, isDone) in
            self.showAlert(with: currentTask) {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            isDone(true)
        }
        
        
        editAction.backgroundColor = .orange
        
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }
    
    @IBAction func  addButtonPressed(_ sender: Any) {
        showAlert()
    }
    
    @IBAction func sortingList(_ sender: UISegmentedControl) {
        taskLists = sender.selectedSegmentIndex == 0
            ? taskLists.sorted(byKeyPath: "name")
            : taskLists.sorted(byKeyPath: "date")
        
        tableView.reloadData()
    }
    
    @objc func back() {
          dismiss(animated: true)
    }
}

extension TaskListTableViewController {
    
    private func showAlert(with taskList: Task? = nil, completion: (() -> Void)? = nil) {
        
        let title = taskList != nil ? "Update" : "New List"
        
        let alert = AlertController(title: title, message: "Please insert new value", preferredStyle: .alert)
        
        alert.action(with: taskList) { newValue in
            if let task = taskList, let completion = completion {
                StorageManager.shared.edit(task: task, newValue: newValue)
                completion()
            } else {
                let taskList = Task()
                taskList.name = newValue
                
                StorageManager.shared.save(task: taskList)
                let rowIndex = IndexPath(row: self.taskLists.count - 1, section: 0)
                self.tableView.insertRows(at: [rowIndex], with: .automatic)
            }
        }
        
        present(alert, animated: true)
    }
    
}

