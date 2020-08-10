//
//  CalculateView.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 24.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

protocol CalculateViewDelegate: class {
    func writeSymbol(symbol: Character)
    func delete()
    func subtraction()
    func multiplication()
    func division()
    func addition()
    func writeResult()
    func percent()
    func writeActionName()
    func deleteAction()
}

@IBDesignable  class CalculateView: UIView {
    // MARK:  IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet var itemButton: UIButton!
    @IBOutlet var leadingConstraint: NSLayoutConstraint!
    @IBOutlet var trallingConstraint: NSLayoutConstraint!
    
    // MARK : IBInspectable
    @IBInspectable var text: String {
        get { itemButton.titleLabel?.text ?? "" }
        set {  itemButton?.setTitle(newValue, for: .normal) }
    }
    
    @IBInspectable var isSupportView: Bool = false {
        didSet {
            
        }
    }
    
    @IBInspectable var typeAdapter: String {
        get { type.rawValue  }
        set { type = CalculateAction(rawValue: newValue) ?? .unknow }
    }
    
    private var type: CalculateAction = .unknow
    
    
    //MARK : Public Proiperty
    var delegate: CalculateViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        itemButton.layer.borderWidth = 1
        itemButton.layer.borderColor = UIColor.systemGray.cgColor
        if isSupportView {
            leadingConstraint.constant = 15
            trallingConstraint.constant = 15
            layoutIfNeeded()
        }
        itemButton.layer.cornerRadius = itemButton.frame.width/2
    }
    
    
    
    
    private func commonInit() {
        let bundle = Bundle(for: CalculateView.self)
        bundle.loadNibNamed("CalculateViewIB", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        itemButton.titleLabel?.text = text
        
    }
    
    @IBAction func action() {
        switch type {
        case .writeNull:
            delegate?.writeSymbol(symbol: "0")
        case .writeOne:
            delegate?.writeSymbol(symbol: "1")
        case .writeTwo:
            delegate?.writeSymbol(symbol: "2")
        case .writeThree:
            delegate?.writeSymbol(symbol: "3")
        case .writeFour:
            delegate?.writeSymbol(symbol: "4")
        case .writeFive:
            delegate?.writeSymbol(symbol: "5")
        case .writeSix:
            delegate?.writeSymbol(symbol: "6")
        case .writeSeven:
            delegate?.writeSymbol(symbol: "7")
        case .writeEight:
            delegate?.writeSymbol(symbol: "8")
        case .writeNine:
            delegate?.writeSymbol(symbol: "9")
        case .writeActionName:
            delegate?.writeActionName()
        case .doAddition:
            delegate?.addition()
        case .doSubtraction:
            delegate?.subtraction()
        case .doMultiplication:
            delegate?.multiplication()
        case .doDivision:
            delegate?.division()
        case .result:
            delegate?.writeResult()
        case .delete:
            delegate?.delete()
        case .doPersent:
            delegate?.percent()
            
        case .writePoint:
            delegate?.writeSymbol(symbol: ".")
        case .unknow:
            break
        case .noAction:
            break
        case .deleteAction:
            delegate?.deleteAction()
        }
        
    }
    
    
}
