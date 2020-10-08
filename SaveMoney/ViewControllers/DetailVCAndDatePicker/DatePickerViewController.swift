//
//  DatePickerViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 08.08.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

final class DatePickerViewController: UIViewController {
    
    public typealias Action = (Date) -> Void
    
    fileprivate var action: Action?
    
    fileprivate lazy var datePicker: UIDatePicker = { [unowned self] in
        $0.addTarget(self, action: #selector(DatePickerViewController.actionForDatePicker), for: .valueChanged)
        $0.preferredDatePickerStyle = .wheels
        return $0
        }(UIDatePicker())
    
    required init(date: Date? = nil, minimumDate: Date? = nil, maximumDate: Date? = nil, locale: Locale? = nil, action: Action?) {
        super.init(nibName: nil, bundle: nil)
        datePicker.datePickerMode = .date
        datePicker.date = date ?? Date()
        datePicker.locale = locale
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = maximumDate
        self.action = action
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = datePicker
    }
    
    @objc func actionForDatePicker() {
        action?(datePicker.date)
    }
}
