//
//  AccountName.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/9/20.
//

import Foundation

public struct AccountName: NamedObject {
    public var name: String
    
    public init(name: String) {
        self.name = name
    }
    
    public static func < (lhs: AccountName, rhs: AccountName) -> Bool {
        return lhs.name < rhs.name
    }
}
