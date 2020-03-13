//
//  ChartOfAccounts.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/9/20.
//

import Foundation

/**
 This is our chart of accounts or holder of all our accounts.
 */
public struct ChartOfAccounts {
    public enum ChartOfAccountsError: Error {
        case accountAlreadyInList
    }
    
    private var accounts = Dictionary<String, Account>()
    
    public var count: Int {
        return accounts.count
    }
    
    public init() {
    }

    subscript(index: String) -> Account? {
        get {
            return accounts[index]
        }
    }
    
    public mutating func addAccountWith(name: String, number: AccountNumber, currency: CurrencyType, entries: Set<Entry> = Set<Entry>()) throws {
        let account = Account(name: name, number: number, currency: currency, entries: entries)
        try addAccount(account)
    }
    
    public mutating func addAccount(_ account: Account) throws {
        if (accounts[account.name] != nil) {
            throw ChartOfAccountsError.accountAlreadyInList
        } else {
            accounts[account.name] = account
        }
    }
    
    public func accountsSorted(_ order: SortOrderType) -> [(key: String, value: Account)] {
        return accounts.sorted(by: { order == SortOrderType.ascending ? $0 < $1 : $0 > $1 })
    }
}
