//
//  AccountingEvent.swift
//
//  Created by Peter Wiley-Cordone on 3/3/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

/**
 Proposed as part of Posting Rule pattern.  This class needs to be overriden and should never be instantiated.
 - Note: See page 13 for discussion about how to handle mutability.  Starts on page 22.
 */
public class AccountingEvent: Event {
    public let id = UUID()
    public let eventType: EventType
    public let whenOccurred: Date
    public var whenNoticed: Date?
    public let otherParty: OtherParty
    public var isProcessed: Bool
    
    public init(otherParty: OtherParty, isProcessed: Bool, whenNoticed: Date?, whenOccurred: Date, eventType: EventType) {
        self.isProcessed = isProcessed
        self.whenNoticed = whenNoticed
        self.whenOccurred = whenOccurred
        self.eventType = eventType
        self.otherParty = otherParty
    }
    
    public static func == (lhs: AccountingEvent, rhs: AccountingEvent) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id.hashValue)
    }
    
    func findRule() -> PostingRule {
        fatalError("Not implemented yet!")
    }
    
    func process() {
        fatalError("Not implemented yet!")
    }
}
