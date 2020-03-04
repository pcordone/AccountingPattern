//
//  AccountingEvent.swift
//
//  Created by Peter Wiley-Cordone on 3/3/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

public class AccountingEventTypes: EventType {
    static let openingbalance = EventType(name: "Opening Balance")
    static let deposit = EventType(name: "Deposit")
    static let withdraw = EventType(name: "Withdraw")
    static let purchase = EventType(name: "Purchase")
    static let transfer = EventType(name: "Transfer")
}

/**
 Proposed as part of Posting Rule pattern.  This class needs to be overriden and should never be instantiated.
 - Note: See page 13 for discussion about how to handle mutability.  Starts on page 22.
 */
public struct AccountingEvent: Event {
    public let id = UUID()
    public let eventType: EventType
    public let whenOccurred: Date
    public var whenNoticed: Date?
    public let otherParty: OtherParty
    public let accountNumber: AccountNumber
    public var isProcessed: Bool
    public var resultingEntries: Set<Entry>
    
    public init(accountNumber: AccountNumber, otherParty: OtherParty, isProcessed: Bool, whenNoticed: Date?, whenOccurred: Date, eventType: EventType, resultingEntries: Set<Entry> = Set<Entry>()) {
        self.isProcessed = isProcessed
        self.whenNoticed = whenNoticed
        self.whenOccurred = whenOccurred
        self.eventType = eventType
        self.accountNumber = accountNumber
        self.otherParty = otherParty
        self.resultingEntries = resultingEntries
    }
    
    public static func == (lhs: AccountingEvent, rhs: AccountingEvent) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id.hashValue)
    }
    
    public mutating func addResultingEntry(_ entry: Entry) {
        self.resultingEntries.insert(entry)
    }
}
