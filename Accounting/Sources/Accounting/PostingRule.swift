//
//  PostingRule.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/4/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

public protocol PostingRule {
    var entryType: EntryType { get }
    func processEvent(_ event: AccountingEvent, withChartOfAccounts COA: ChartOfAccounts) throws
}

/// This simple posting rule generates the entry for the single account passed in.   Other posting rules could generate entries accross accounts (for example, a transfer or a paycheck that is split into several accounts).
public struct PostingRuleToOneAccount: PostingRule {
    enum PostingRuleToOneAccountError: Error {
        case onlyOneAccountAllowedToBeProcessed
    }
    public var entryType: EntryType

    public init(entryType: EntryType) {
        self.entryType = entryType
    }
    
    public func processEvent(_ event: AccountingEvent, withChartOfAccounts COA: ChartOfAccounts) throws {
//        guard accounts.count == 1 else {
//            throw PostingRuleToOneAccount.PostingRuleToOneAccountError.onlyOneAccountAllowedToBeProcessed
//        }
//        guard let moneyEvent = event as? MoneyEvent else {
//            fatalError("A non MoneyEvent was passed for processing.")
//        }
//        var account = accounts[0]
//        try account.addEntry(type: entryType, eventId: moneyEvent.id, amount: moneyEvent.amount, date: moneyEvent.whenOccurred, otherParty: moneyEvent.otherParty)
    }
}
