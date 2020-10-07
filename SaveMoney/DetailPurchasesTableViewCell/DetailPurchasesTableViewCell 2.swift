//
//  DetailPurchasesTableViewCell.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 11.08.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class DetailPurchasesTableViewCell: UITableViewCell {

    static let identifier = "DetailPurchasesTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "DetailPurchasesTableViewCell",
                     bundle: nil)
    }
        
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var amountLabel: UILabel!
   
    
}

