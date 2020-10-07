//
//  AlertController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 07.10.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

import UIKit

class AlertController: UIAlertController {
    
    var doneButton = "Save"
    
    func action(with taskList: Task?, completion: @escaping (String) -> Void) {
        
        if taskList != nil { doneButton = "Update" }
        
        let saveAction = UIAlertAction(title: doneButton, style: .default) { _ in
            guard let newValue = self.textFields?.first?.text else { return }
            guard !newValue.isEmpty else { return }
            completion(newValue)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "List Name"
            textField.text = taskList?.name
        }
    }
    
}

