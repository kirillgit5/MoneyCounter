//
//  DetailMoneyCategoryViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 13.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class DetailMoneyCategoryViewController: UIViewController {

    // MARK : - Public Property
    var moneyCatigory: MoneyCategory!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK : Private Methods
    private func setupNavigationBar() {
        title = moneyCatigory.name
        
    }
    
}
