//
//  AccountingEvent.swift
//
//  Created by Peter Wiley-Cordone on 3/3/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

/**
 Proposed as part of Posting Rule pattern.
 - Note: Starts on page 22.  See page 13 for discussion about how to handle mutability.
 */
public struct AccountingEvent: Event, Identifiable {
    public static let POSTING_EVENT_TYPE: EventType = EventType(name: "posting")
    
    public var name: String
    public let id: UUID
    public let whenOccurred: Date
    public var whenNoticed: Date?
    public var isProcessed: Bool
    public var type: EventType
    public let otherParty: OtherParty
    public let amount: Money
    public var account: Account
    public let entryType: EntryType
    public let note: String?

    public init(name: String, whenOccurred: Date, whenNoticed: Date?, isProcessed: Bool, otherParty: OtherParty, amount: Money, account: Account, entryType: EntryType, note: String? = nil, id: UUID = UUID()) {
        self.name = name
        self.type = AccountingEvent.POSTING_EVENT_TYPE
        self.whenOccurred = whenOccurred
        self.whenNoticed = whenNoticed
        self.isProcessed = isProcessed
        self.otherParty = otherParty
        self.amount = amount
        self.account = account
        self.entryType = entryType
        self.id = id
        self.note = note
    }
}


extension AccountingEvent: Hashable {
    public var hashValue: Int {
        var hasher = Hasher()
        self.hash(into: &hasher)
        return hasher.finalize()
    }
    
    public static func == (lhs: AccountingEvent, rhs: AccountingEvent) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id.hashValue)
    }
}
