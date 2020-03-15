//
//  PostToSingleAccountEvent.swift
//  AccountingTests
//
//  Created by Peter Wiley-Cordone on 3/14/20.
//

import Foundation

/**
 This event posts entries to a single account.
 */
public struct PostToSingleAccountEvent: AccountingEvent {
    public var id = UUID()
    public var name: String
    public var whenOccurred: Date
    public var whenNoticed: Date?
    public var isProcessed: Bool
    public var eventType: AccountingEventType
    public var otherParty: OtherParty
    public var amount: Money
    public var postToAccount: Account
    public var postFromAccount: Account
    
    public init(name: String, whenOccurred: Date, whenNoticed: Date?, isProcessed: Bool, eventType: AccountingEventType, otherParty: OtherParty, amount: Money, postToAccount: Account, postFromAccount: Account) {
        self.name = name
        self.whenOccurred = whenOccurred
        self.whenNoticed = whenNoticed
        self.isProcessed = isProcessed
        self.eventType = eventType
        self.otherParty = otherParty
        self.amount = amount
        self.postToAccount = postToAccount
        self.postFromAccount = postFromAccount
    }
    
    public func findRule() -> SingleAccountEntryPostingRule {
//        guard let postingRule =
        fatalError("Not implemented yet!")
    }
    
    public func process() throws {
        //try findRule().processEvent(&self)
    }
}
