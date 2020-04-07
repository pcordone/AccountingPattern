//
//  File.swift
//  
//
//  Created by Peter Wiley-Cordone on 4/5/20.
//

import Foundation

public struct DebitsCredits {
    public static var zero = DebitsCredits(debit: Decimal.zero, credit: Decimal.zero)
    
    var debit: Decimal
    var credit: Decimal
    
    public init(_ balance: DebitsCredits) {
        self.debit = balance.debit
        self.credit = balance.credit
    }
    
    public init(debit: Decimal, credit: Decimal) {
        self.debit = debit
        self.credit = credit
    }
    
    /**
     */
    public func balanceForAccountType(_ accountType: AccountType) -> Decimal {
        switch (accountType) {
        case .asset: // Asset accounts. A debit increases the balance and a credit decreases the balance.
            return debit - credit
        case .expense: //Expense accounts. A debit increases the balance and a credit decreases the balance.
            return debit - credit
        case .income: // Revenue accounts. A debit decreases the balance and a credit increases the balance.
            return credit - debit
        case .liability: // Liability accounts. A debit decreases the balance and a credit increases the balance.
            return credit - debit
        case .equity: // Equity accounts. A debit decreases the balance and a credit increases the balance.
            return credit - debit
        }
    }
}

extension DebitsCredits: Hashable {
    public var hashValue: Int {
        var hasher = Hasher()
        self.hash(into: &hasher)
        return hasher.finalize()
    }
    
    public static func == (lhs: DebitsCredits, rhs: DebitsCredits) -> Bool {
        return (lhs.debit == rhs.debit) && (lhs.credit == rhs.credit)
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.debit)
        hasher.combine(self.credit)
    }
}

extension DebitsCredits: AdditiveArithmetic {
    /// Minus equal a Balance
    public static func -= (lhs: inout DebitsCredits, rhs: DebitsCredits) {
        if !rhs.debit.isZero {
            lhs.debit -= rhs.debit
        }
        if !rhs.credit.isZero {
            lhs.credit -= rhs.credit
        }
    }
    
    /// Adds one monetary amount to another.
    public static func += (lhs: inout DebitsCredits, rhs: DebitsCredits) {
        if !rhs.debit.isZero {
            lhs.debit += rhs.debit
        }
        if !rhs.credit.isZero {
            lhs.credit += rhs.credit
        }
    }
    
    /// Minus equal a Balance and an Entry
    public static func -= (lhs: inout DebitsCredits, rhs: Entry) {
        switch(rhs.type) {
        case .debit:
            if !rhs.amount.amount.isZero {
                lhs.debit -= rhs.amount.amount
            }
        case .credit:
            if !rhs.amount.amount.isZero {
                lhs.credit -= rhs.amount.amount
            }
        }
    }
    
    /// Minus equal a Balance and an Entry
    public static func += (lhs: inout DebitsCredits, rhs: Entry) {
        switch(rhs.type) {
        case .debit:
            if !rhs.amount.amount.isZero {
                lhs.debit += rhs.amount.amount
            }
        case .credit:
            if !rhs.amount.amount.isZero {
                lhs.credit += rhs.amount.amount
            }
        }
    }
    
    /// The difference between two Balance objects.
    public static func - (lhs: DebitsCredits, rhs: DebitsCredits) -> DebitsCredits {
        return DebitsCredits(debit: rhs.debit.isZero ? lhs.debit : lhs.debit - rhs.debit,
                       credit: rhs.credit.isZero ? lhs.credit : lhs.credit - rhs.credit)
    }
    
    /// The sum of two Balance objects.
    public static func + (lhs: DebitsCredits, rhs: DebitsCredits) -> DebitsCredits {
        return DebitsCredits(debit: rhs.debit.isZero ? lhs.debit : lhs.debit + rhs.debit,
                       credit: rhs.credit.isZero ? lhs.credit : lhs.credit + rhs.credit)
    }
    
    /// The differene between a Balance and an Entry
    public static func - (lhs: DebitsCredits, rhs: Entry) -> DebitsCredits {
        var debitAmount = lhs.debit
        var creditAmount = lhs.credit
        switch(rhs.type) {
        case .debit:
            if !rhs.amount.amount.isZero {
                debitAmount -= rhs.amount.amount
            }
        case .credit:
            if !rhs.amount.amount.isZero {
                creditAmount -= rhs.amount.amount
            }
        }
        return DebitsCredits(debit: debitAmount, credit: creditAmount)
    }
    
    /// The difference between a Balance and an Entry
    public static func + (lhs: DebitsCredits, rhs: Entry) -> DebitsCredits {
        var debitAmount = lhs.debit
        var creditAmount = lhs.credit
        switch(rhs.type) {
        case .debit:
            if !rhs.amount.amount.isZero {
                debitAmount += rhs.amount.amount
            }
        case .credit:
            if !rhs.amount.amount.isZero {
                creditAmount += rhs.amount.amount
            }
        }
        return DebitsCredits(debit: debitAmount, credit: creditAmount)
    }
}
