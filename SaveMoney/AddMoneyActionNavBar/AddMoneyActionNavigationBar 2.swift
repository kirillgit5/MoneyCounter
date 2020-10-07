//
//  addMoneyActionNavigationBar.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 21.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

protocol AddMoneyActionNavigationBarDelegate: class {
    func back()
    func addMoneyCategory()
}

@IBDesignable class AddMoneyActionNavigationBar: UINavigationBar {
    
    // MARK : - IBOutlets
    @IBOutlet var title: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var goToMainVCButton: UIButton!
    @IBOutlet var backButton: UIButton!
    
    // MARK : - Public Propety
    weak var delegat: AddMoneyActionNavigationBarDelegate?
    
    //MARK : - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    //MARK : - Public Methods
    func setupText(text: String) {
        title.text = text
    }
    
    func setupNavBarSecondType() {
        goToMainVCButton.isHidden = true
        backButton.isHidden = false
    }
    
    
    private func commonInit() {
        let bundle = Bundle(for: AddMoneyActionNavigationBar.self)
        bundle.loadNibNamed("AddMoneyActionNavigationBarIB", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    
    
    
    
    // MARK : - IBActions
    @IBAction func back() {
        delegat?.back()
    }
    
    
    @IBAction func addMoneyAction() {
        delegat?.addMoneyCategory()
    }
    
}
