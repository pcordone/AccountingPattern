//
//  AccountingEvent.swift
//
//  Created by Peter Wiley-Cordone on 3/3/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

/**
 Proposed as part of Posting Rule pattern.
 - Note: See page 13 for discussion about how to handle mutability.  Starts on page 22.
 */
public class AccountingEvent: Event, Identifiable {
    public enum AccountingEventError: Error {
        case cantFindPostingRuleForEventType
    }
    public var name: String
    public let id = UUID()
    public let whenOccurred: Date
    public var whenNoticed: Date?
    public var isProcessed: Bool
    public let eventType: AccountingEventType
    public let otherParty: OtherParty
    public let agreement: ServiceAgreement
    public let amount: Money
    public let account: Account
    public let entryType: EntryType

    public init(name: String, eventType: AccountingEventType, whenOccurred: Date, whenNoticed: Date?, isProcessed: Bool, otherParty: OtherParty, agreement: ServiceAgreement, amount: Money, account: Account, entryType: EntryType) {
        self.name = name
        self.eventType = eventType
        self.whenOccurred = whenOccurred
        self.whenNoticed = whenNoticed
        self.isProcessed = isProcessed
        self.otherParty = otherParty
        self.agreement = agreement
        self.amount = amount
        self.account = account
        self.entryType = entryType
    }
    
    public func process() throws {
        try findRule().processEvent(self)
    }
    
    public func findRule() throws -> PostingRule {
        guard let postingRule = agreement.getPostingRuleForEventType(eventType, date: whenOccurred) else {
            throw AccountingEventError.cantFindPostingRuleForEventType
        }
        return postingRule
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
