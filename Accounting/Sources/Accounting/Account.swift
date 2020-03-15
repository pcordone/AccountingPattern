//
//  Account.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/3/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

/**
 Collect together related accounting entries and provide summarizing behavior.
 - Note: Starts on page 39.
 - ToDo: Need to incorporate MoneyBag for balance calculations and return it.
 - ToDo: Do I also want to put in validation for enforcing a XF transaction for when currency of entries change or more generally, how do we support spending across currencies?  I probably want to create a new account for the new currency.
 */
public struct Account: NamedObject, Equatable {
    public var name: String
    
    enum AccountError: Error {
        case attemptedToAddEntryWhereAmountCurrencyDoesNotMatchAccountCurrency
    }
    
    public let id = UUID()
    public let number: AccountNumber
    public let currency: CurrencyType
    public var entries: Set<Entry>
    
    public init(name: String, number: AccountNumber, currency: CurrencyType, entries: Set<Entry> = Set<Entry>()) {
        self.name = name
        self.number = number
        self.currency = currency
        self.entries = entries
    }
    
    public static func < (lhs: Account, rhs: Account) -> Bool {
        return lhs.name < rhs.name
    }
    
    public static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id.hashValue)
    }
    
    public mutating func addEntry(_ entry: Entry) throws {
        guard self.currency == entry.amount.currency else {
             throw AccountError.attemptedToAddEntryWhereAmountCurrencyDoesNotMatchAccountCurrency
         }
        self.entries.insert(entry)
    }
    
    public mutating func addEntry(type: EntryType, eventId: UUID, amount: Money, date: Date, otherParty: OtherParty) throws {
        try addEntry(Entry(eventId: eventId, date: date, entryType: type, amount: amount, otherParty: otherParty))
    }

    @available(iOS 10.0, *)
    public func balanceBetween(_ interval: DateInterval) -> Money {
        return Money(self.entries.filter({ interval.contains($0.date) })
                           .reduce(0, { result, entry in result + entry.amount.amount }),
                     self.currency)
    }
    
    public func balanceAsOf(_ asOfDate: Date) -> Money {
        return Money(self.entries.filter({ $0.date >= asOfDate })
                         .reduce(0, { result, entry in result + entry.amount.amount }),
                     self.currency)
    }
    
    public func balance() -> Money {
        return balanceAsOf(Date())
    }
    
    @available(iOS 10.0, *)
    public func depositsBetween(_ interval: DateInterval) -> Money {
        return Money(self.entries.filter({ interval.contains($0.date) && $0.amount > 0 })
            .reduce(0, { result, entry in result + entry.amount.amount }),
                     self.currency)
    }
    
    @available(iOS 10.0, *)
    public func withdrawlsBetween(_ interval: DateInterval) -> Money {
        return Money(self.entries.filter({ interval.contains($0.date) && $0.amount < 0 })
            .reduce(Decimal(0), {result, entry in result + entry.amount.amount}),
                     self.currency)
    }
}
