//
//  ChartOfAccounts.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/9/20.
//

import Foundation

public enum ChartOfAccountsError: Error {
    case accountAlreadyExists
    case cantFindAccount
}

/**
 This is our chart of accounts or holder of all our accounts.
 */
public class ChartOfAccounts {
    public var accounts = Set<Account>()
    
    public init() {
    }

    // MARK: Accessing and managing accounts

    public var count: Int {
        return accounts.count
    }
    
    func addAccount(name: String, type: AccountType, number: AccountNumber, currency: CurrencyType = CurrencyType.currencyForDefaultLocale(), entries: Set<Entry> = Set<Entry>()) throws {
        let account = Account(name: name, type: type, number: number, currency: currency, entries: entries)
        try addAccount(account)
    }
    
    func addAccount(_ account: Account) throws {
        if (accounts.contains(account)) {
            throw ChartOfAccountsError.accountAlreadyExists
        } else {
            accounts.insert(account)
        }
    }
    
    func updateAccount(_ account: Account) throws {
        guard accounts.contains(account) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        accounts.update(with: account)
    }
    
    func deleteAccount(_ account: Account) throws {
        guard accounts.contains(account) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        accounts.remove(account)
    }
    
    public func accountsSorted(_ order: SortOrderType, includeHidden: Bool = false) -> [Account] {
        return accounts.filter({ $0.hidden && includeHidden || !$0.hidden }).sorted(by: { order == SortOrderType.ascending ? $0.name < $1.name : $0.name > $1.name })
        }
    
    // MARK: Managing tags
    
    public subscript(index: String, forCategory category: String = "", includeHidden: Bool = false) -> [Account] {
        get {
            return accounts.filter({ ($0.hidden && includeHidden || !$0.hidden) && $0.hasTag(index, forCategory: category) }).map( {$0} )
        }
    }
}
