//
//  File.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/3/20.
//

import Foundation

public struct Account: NamedObject, Equatable, Hashable {
    public let id = UUID()
    public var name: String
    
    public static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.id == rhs.id
    }
    
    public init(name: String) {
        self.name = name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id.hashValue)
    }
}
