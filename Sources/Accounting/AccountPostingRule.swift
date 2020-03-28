//
//  SingleAccountEntryPostingRule.swift
//  Accounting
//
//  Created by Peter Wiley-Cordone on 3/15/20.
//

import Foundation

/// This simple posting rule generates the entry for the single account passed in.   Other posting rules could generate entries accross accounts (for example, a transfer or a paycheck that is split into several accounts).
public struct AccountPostingRule: PostingRule, Identifiable {    
    public var id: UUID
    
    public init(id: UUID = UUID()) {
        self.id = id
    }
    
    public func processEvent(_ event: inout AccountingEvent) throws {
        try event.account.addEntry(eventId: event.id, type: event.entryType, amount: event.amount, date: event.whenOccurred, otherParty: event.otherParty)
        assert(event.account.entries.count > 0)
    }
}

extension AccountPostingRule: Hashable {
    public var hashValue: Int {
        return self.id.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id.hashValue)
    }
    
    public static func == (lhs: AccountPostingRule, rhs: AccountPostingRule) -> Bool {
        return lhs.id == rhs.id
    }
}
