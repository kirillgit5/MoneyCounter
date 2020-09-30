//
//  Protocols.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 22.09.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import Foundation

protocol Copying {
    init(_ prototype: Self)
}

extension Copying {
    public func copy() -> Self {
        type(of: self).init(self)
    }
}
