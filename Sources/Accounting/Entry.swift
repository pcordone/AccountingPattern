//
//  Entry.swift
//
//  Created by Peter Wiley-Cordone on 3/3/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

/**
 Proposed as part of Posting Rule pattern.
 - Note: Starts on page 23.  I called CostType Account since it's more consistent with accounting nomenclature (i.e. accounts are in the chart of accounts).  I added eventId since I want every entry to be able to trace back to the origin event.
 */
public struct Entry: Identifiable {
    public let id: UUID
    public let eventId: UUID
    public let date: Date
    public let type: EntryType
    public let amount: Money
    public let otherParty: OtherParty
    public let note: String?
    
    public init(eventId: UUID, date: Date, entryType: EntryType, amount: Money, otherParty: OtherParty, note: String? = nil, id: UUID = UUID()) {
        self.id = id
        self.eventId = eventId
        self.date = date
        self.type = entryType
        self.amount = amount
        self.otherParty = otherParty
        self.note = note
    }
}

extension Entry: Hashable {
    public var hashValue: Int {
        get {
            var hasher = Hasher()
            self.hash(into: &hasher)
            return hasher.finalize()
        }
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id.hashValue)
    }
    
    public static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.id == rhs.id
    }
}
