//
//  DateChooseView.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 07.08.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

protocol DateChooseViewDelegate {
    func chooseDate()
}

@IBDesignable class DateChooseView: UIView {
    
    // MARK : IB Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet var dateLabel: UILabel!
    
    // MARK : Public Property
    var delegate: DateChooseViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: MainNavigationBar.self)
        bundle.loadNibNamed("DateChooseViewIB", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    
    @IBAction func chooseDate() {
        delegate?.chooseDate()
    }
    
}
