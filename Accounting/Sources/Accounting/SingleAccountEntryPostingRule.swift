//
//  SingleAccountEntryPostingRule.swift
//  Accounting
//
//  Created by Peter Wiley-Cordone on 3/15/20.
//

import Foundation

/// This simple posting rule generates the entry for the single account passed in.   Other posting rules could generate entries accross accounts (for example, a transfer or a paycheck that is split into several accounts).
public struct SingleAccountEntryPostingRule: PostingRule {
    public var entryType: EntryType

    public init(entryType: EntryType) {
        self.entryType = entryType
    }
    
    public func processEvent(_ event: inout PostToSingleAccountEvent) throws {
        try event.postToAccount.addEntry(type: entryType, eventId: event.id, amount: event.amount, date: event.whenOccurred, otherParty: event.otherParty)
        try event.postFromAccount.addEntry(type: entryType, eventId: event.id, amount: -1 * event.amount, date: event.whenOccurred, otherParty: event.otherParty)
    }
}
