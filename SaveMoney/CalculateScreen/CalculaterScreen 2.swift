//
//  CalculaterScreen.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 26.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit


class CalculaterScreen: UIView {

    @IBOutlet var operationTypeLabel: UILabel!
    @IBOutlet var calculateLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
           let bundle = Bundle(for: CalculaterScreen.self)
           bundle.loadNibNamed("CalculaterScreenIB", owner: self)
           addSubview(contentView)
           contentView.frame = self.bounds
           contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
           
       }
    
    

}
