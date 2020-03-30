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
public class ChartOfAccounts {
    public enum ChartOfAccountsError: Error {
        case accountAlreadyInList
    }
    
    var accounts = Dictionary<UUID, Account>()
    
    public var count: Int {
        return accounts.count
    }
        
    public init() {
    }

    subscript(index: UUID) -> Account? {
        get {
            return accounts[index]
        }
    }
    
    public func addAccount(name: String, type: AccountType, number: AccountNumber, currency: CurrencyType = CurrencyType.currencyForDefaultLocale(), entries: Set<Entry> = Set<Entry>()) throws {
        let account = Account(name: name, type: type, number: number, currency: currency, entries: entries)
        try addAccount(account)
    }
    
    public func addAccount(_ account: Account) throws {
        if (accounts[account.id] != nil) {
            throw ChartOfAccountsError.accountAlreadyInList
        } else {
            accounts[account.id] = account
        }
    }
    
    public func accountsSorted(_ order: SortOrderType) -> [(key: UUID, value: Account)] {
        return accounts.sorted(by: { order == SortOrderType.ascending ? $0.value.name < $1.value.name : $0.value.name > $1.value.name })
    }
}
