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
public struct OtherParty: Hashable, Identifiable {
    public let id = UUID()
    public let name: String

    public static func == (lhs: OtherParty, rhs: OtherParty) -> Bool {
        return lhs.id == rhs.id
    }
    
    public init(name: String) {
        self.name = name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id.hashValue)
    }
}
