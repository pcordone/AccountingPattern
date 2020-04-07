//
//  Account.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/3/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

public enum AccountType: String {
    case asset = "Asset"
    case expense = "Expense"
    case income = "Income"
    case liability = "Liability"
    case equity = "Equity"
}

extension AccountType: CaseIterable {
}

/**
 Collect together related accounting entries and provide summarizing behavior.
 - Note: Starts on page 39.
 - Note:Debits and credits from accounting principles:
 Asset accounts. A debit increases the balance and a credit decreases the balance.
 Liability accounts. A debit decreases the balance and a credit increases the balance.
 Equity accounts. A debit decreases the balance and a credit increases the balance.
 Revenue accounts. A debit decreases the balance and a credit increases the balance.
 Expense accounts. A debit increases the balance and a credit decreases the balance.
 Gain accounts. A debit decreases the balance and a credit increases the balance.
 Loss accounts. A debit increases the balance and a credit decreases the balance.
 - ToDo: Need to incorporate MoneyBag for balance calculations and return it.
 - ToDo: Do I also want to put in validation for enforcing a XF transaction for when currency of entries change or more generally, how do we support spending across currencies?  I probably want to create a new account for the new currency.
 */
public struct Account: NamedObject {
    enum AccountError: Error {
        case attemptedToAddEntryWhereAmountCurrencyDoesNotMatchAccountCurrency
        case cantFindTagCategory
    }
    
    public var name: String
    public let id: UUID
    public let type: AccountType
    public let number: AccountNumber
    public let currency: CurrencyType
    public var hidden: Bool
    public var tags: Dictionary<String, Set<String>>
    public var entries: Set<Entry>
    
    public init(name: String, type: AccountType, number: AccountNumber, currency: CurrencyType, hidden: Bool = false, tags: Dictionary<String, Set<String>> = Dictionary<String, Set<String>>(), id: UUID = UUID(), entries: Set<Entry> = Set<Entry>()) {
        self.id = id
        self.name = name
        self.type = type
        self.number = number
        self.currency = currency
        self.hidden = hidden
        self.tags = tags
        self.entries = entries
    }
    
    private func signedAmountForEntry(_ entry: Entry) -> Decimal {
        switch (type) {
        case .asset: // Asset accounts. A debit increases the balance and a credit decreases the balance.
            return entry.type == .credit ? entry.amount.amount * -1 : entry.amount.amount
        case .expense: //Expense accounts. A debit increases the balance and a credit decreases the balance.
            return entry.type == .credit ? entry.amount.amount * -1 : entry.amount.amount
        case .income: // Revenue accounts. A debit decreases the balance and a credit increases the balance.
            return entry.type == .debit ? entry.amount.amount * -1 : entry.amount.amount
        case .liability: // Liability accounts. A debit decreases the balance and a credit increases the balance.
            return entry.type == .debit ? entry.amount.amount * -1 : entry.amount.amount
        case .equity: // Equity accounts. A debit decreases the balance and a credit increases the balance.
            return entry.type == .debit ? entry.amount.amount * -1 : entry.amount.amount
        }
    }
    
    public mutating func addEntry(_ entry: Entry) throws {
        guard currency == entry.amount.currency else {
             throw AccountError.attemptedToAddEntryWhereAmountCurrencyDoesNotMatchAccountCurrency
         }
        entries.insert(entry)
    }
    
    public mutating func addEntry(eventId: UUID, type: EntryType, amount: Money, date: Date, otherParty: OtherParty, note: String? = nil, id: UUID = UUID()) throws {
        let entry = Entry(eventId: eventId, date: date, entryType: type, amount: amount, otherParty: otherParty, note: note, id: id)
        try addEntry(entry)
    }
    
    public mutating func addTag(_ tag: String, forCategory: String = "") {
        if !tags.contains(where: {$0.key == forCategory }) {
            tags[forCategory] = Set<String>()
        }
        tags[forCategory]!.insert(tag)
    }
    
    public mutating func removeTag(_ tag: String, forCategory: String = "") throws {
        guard tags.contains(where: {$0.key == forCategory}) else {
            throw AccountError.cantFindTagCategory
        }
        tags[forCategory]!.remove(tag)
    }
    
    public func hasTag(_ tag: String, forCategory: String = "") -> Bool {
        return tags[forCategory]?.contains(tag) ?? false
    }
    
    public mutating func removeAllTags() {
        tags.removeAll()
    }
    
    public mutating func removeAllTagsForCategory(_ category: String) throws {
        guard tags.contains(where: {$0.key == category}) else {
            throw AccountError.cantFindTagCategory
        }
        tags[category]!.removeAll()
    }
    
    @available(OSX 10.12, *)
    @available(iOS 10.0, *)
    public func balanceBetween(_ interval: DateInterval) -> Money {
        return Money(debitsCreditsBetween(interval).balanceForAccountType(type), currency)
    }
    
    @available(OSX 10.12, *)
    @available(iOS 10.0, *)
    public func debitsCreditsBetween(_ interval: DateInterval) -> DebitsCredits {
        return DebitsCredits(entries.filter({ interval.contains($0.date) })
                           .reduce(DebitsCredits(debit: 0, credit: 0), { result, entry in result + entry }))
    }
    
    public func balanceAsOf(_ asOfDate: Date) -> Money {
        return Money(debitsCreditsAsOf(asOfDate).balanceForAccountType(type), currency)
    }
    
    public func debitsCreditsAsOf(_ asOfDate: Date) -> DebitsCredits {
        return DebitsCredits(entries.filter({ $0.date <= asOfDate })
                         .reduce(DebitsCredits(debit: 0, credit: 0), { result, entry in result + entry }))
    }
    
    public func balance() -> Money {
        return balanceAsOf(Date())
    }
    
    @available(OSX 10.12, *)
    @available(iOS 10.0, *)
    public func debitsBetween(_ interval: DateInterval) -> Money {
        return Money(entries.filter({ interval.contains($0.date) && $0.type == .debit })
            .reduce(0, { result, entry in result + entry.amount.amount }),
                     currency)
    }
    
    @available(OSX 10.12, *)
    @available(iOS 10.0, *)
    public func creditsBetween(_ interval: DateInterval) -> Money {
        return Money(entries.filter({ interval.contains($0.date) && $0.type == .credit })
            .reduce(Decimal(0), {result, entry in result + entry.amount.amount}),
                     currency)
    }
}

extension Account: Hashable {
    public var hashValue: Int {
        return id.hashValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id.hashValue)
    }
}

extension Account: Equatable {
    public static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.id == rhs.id
    }
}
