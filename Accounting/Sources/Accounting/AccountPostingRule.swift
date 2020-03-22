//
//  SingleAccountEntryPostingRule.swift
//  Accounting
//
//  Created by Peter Wiley-Cordone on 3/15/20.
//

import Foundation

/// This simple posting rule generates the entry for the single account passed in.   Other posting rules could generate entries accross accounts (for example, a transfer or a paycheck that is split into several accounts).
public class AccountPostingRule: PostingRule {
    public init() {
    }
    
    public func processEvent(_ event: AccountingEvent) throws {
        try event.account.addEntry(eventId: event.id, type: event.entryType, amount: event.amount, date: event.whenOccurred, otherParty: event.otherParty)
    }
}
