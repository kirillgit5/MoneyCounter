//
//  Boxing.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 12.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation


class Box<T> {
    
    typealias Listener = ((T) -> Void)
    
    private var listener: Listener?
    
     var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
    
    
}
