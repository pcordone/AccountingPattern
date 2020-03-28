//
//  Customer.swift
//  sophrosyne
//
//  Created by Peter Wiley-Cordone on 3/3/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

/**
 Proposed as part of Posting Rule pattern as Customer.  I am calling it OtherParty to be indifferent as to payees, customers or institutions (i.e. Banks, Credit Card companies, etc.)
 - Note: Starts on page 23.
 */
public struct OtherParty: Identifiable {
    public let id = UUID()
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}

extension OtherParty: Hashable {
    public var hashValue: Int {
        return self.id.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id.hashValue)
    }
    
    public static func == (lhs: OtherParty, rhs: OtherParty) -> Bool {
        return lhs.id == rhs.id
    }
}
