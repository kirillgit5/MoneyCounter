//
//  CalculateView.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 24.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

protocol CalculateViewDelegate: class {
    func writeSymbol(action: CalculateActionWithNumber)
    func doOperate(operate: CalculateActionWithOperate)
    func writeResult()
    func writeActionName()
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
        set { type = CalculateAction(rawValue: newValue) ?? .noAction }
    }
    
    private var type: CalculateAction = .noAction
    
    
    //MARK : Public Proiperty
    weak var delegate: CalculateViewDelegate?
    
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
            delegate?.writeSymbol(action: .writeNull)
        case .writeOne:
            delegate?.writeSymbol(action: .writeOne)
        case .writeTwo:
            delegate?.writeSymbol(action: .writeTwo)
        case .writeThree:
            delegate?.writeSymbol(action: .writeThree)
        case .writeFour:
            delegate?.writeSymbol(action: .writeFour)
        case .writeFive:
            delegate?.writeSymbol(action: .writeFive)
        case .writeSix:
            delegate?.writeSymbol(action: .writeSix)
        case .writeSeven:
            delegate?.writeSymbol(action: .writeSeven)
        case .writeEight:
            delegate?.writeSymbol(action: .writeEight)
        case .writeNine:
            delegate?.writeSymbol(action: .writeNine)
        case .writeActionName:
            delegate?.writeActionName()
        case .doAddition:
            delegate?.doOperate(operate: .doAddition)
        case .doSubtraction:
            delegate?.doOperate(operate: .doSubtraction)
        case .doMultiplication:
            delegate?.doOperate(operate: .doMultiplication)
        case .doDivision:
            delegate?.doOperate(operate: .doDivision)
        case .calculateResult:
            delegate?.writeResult()
        case .delete:
            delegate?.writeSymbol(action: .delete)
        case .doPersent:
            delegate?.doOperate(operate: .doPersent)
            
        case .writePoint:
            delegate?.writeSymbol(action: .writePoint)
        
        case .noAction:
            break
        case .deleteAction:
            delegate?.doOperate(operate: .deleteAction)
        }
        
    }
    
    
}
