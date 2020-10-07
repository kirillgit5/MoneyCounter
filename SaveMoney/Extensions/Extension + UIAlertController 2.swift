//
//  Extension + UIAlertController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 08.08.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit
import AudioUnit

extension UIAlertController {
    func addDatePicker(date: Date?, minimumDate: Date? = nil, maximumDate: Date? = nil, locale: Locale? = nil, action: DatePickerViewController.Action?) {
        
        let datePicker = DatePickerViewController(date: date, minimumDate: minimumDate, maximumDate: maximumDate, locale: locale, action: action)
        set(vc: datePicker, height: 220)
    }
    
    func set(vc: UIViewController? , width: CGFloat? = nil, height: CGFloat? = nil) {
        guard let vc = vc else { return }
        setValue(vc, forKey: "contentViewController")
        if let height = height {
            vc.preferredContentSize.height = height
            preferredContentSize.height = height
        }
    }
    
    public func show(animated: Bool = true, vibrate: Bool = false, viewController: UIViewController , completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            viewController.present(self, animated: animated, completion: completion)
            if vibrate {
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            }
        }
    }
    
}

extension UIAlertController {
    
    convenience init(style: Style, source: UIView , title: String? = nil, message: String? = nil) {
        self.init(title: title, message: message, preferredStyle: style)
        popoverPresentationController?.sourceView = source
        popoverPresentationController?.sourceRect = source.bounds
        
    }
}

