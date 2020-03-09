//
//  MoneyAccountingEvent.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/8/20.
//

import Foundation

public class MoneyEventTypes: EventType {
    static let openingbalance = EventType(name: "Opening Balance")
    static let deposit = EventType(name: "Deposit")
    static let withdraw = EventType(name: "Withdraw")
    static let purchase = EventType(name: "Purchase")
    static let transfer = EventType(name: "Transfer")
}

public class MoneyEvent: AccountingEvent {
    let amount: Money
    
    public init(otherParty: OtherParty, isProcessed: Bool, whenNoticed: Date?, whenOccurred: Date, eventType: EventType, amount: Money) {
        self.amount = amount
        super.init(otherParty: otherParty, isProcessed: isProcessed, whenNoticed: whenNoticed, whenOccurred: whenOccurred, eventType: eventType)
    }
}
