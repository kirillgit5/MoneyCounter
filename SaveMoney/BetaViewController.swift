//
//  BetaViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 07.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class BetaViewController: UIViewController {

     private let betaPushases = BetaPurchasesCategoryCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(betaPushases)
        
    }
}
