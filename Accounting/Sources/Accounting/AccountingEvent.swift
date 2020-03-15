//
//  AccountingEvent.swift
//
//  Created by Peter Wiley-Cordone on 3/3/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

public struct AccountingEventType: EventType {
    public var id: UUID = UUID()
    public var name: String
    static let openingbalance = AccountingEventType(name: "Opening Balance")
    static let deposit = AccountingEventType(name: "Deposit")
    static let withdraw = AccountingEventType(name: "Withdraw")
    static let purchase = AccountingEventType(name: "Purchase")
    static let transfer = AccountingEventType(name: "Transfer")
}

/**
 Proposed as part of Posting Rule pattern.  This class needs to be overriden and should never be instantiated.
 - Note: See page 13 for discussion about how to handle mutability.  Starts on page 22.
 */
public protocol AccountingEvent: Event {
    associatedtype PostingRuleType
    var otherParty: OtherParty { get }
    var amount: Money { get }
    func findRule() throws -> PostingRuleType
    func process() throws
}

extension AccountingEvent {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id.hashValue)
    }
}
