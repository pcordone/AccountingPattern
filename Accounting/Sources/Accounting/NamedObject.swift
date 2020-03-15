//
//  NamedObject.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/3/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

public protocol NamedObject: Hashable, Comparable {
    var name: String { get set }
}

extension NamedObject {    
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.name < rhs.name
    }
}
