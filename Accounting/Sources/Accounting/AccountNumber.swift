//
//  AccountNumber.swift
//
//  Created by Peter Wiley-Cordone on 3/3/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

public struct AccountNumber: Hashable, Identifiable {
    public let id = UUID()
    public let number: String
    
    public static func == (lhs: AccountNumber, rhs: AccountNumber) -> Bool {
        return lhs.id == rhs.id
    }
    
    public init(_ number: String) {
        self.number = number
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id.hashValue)
    }
}
