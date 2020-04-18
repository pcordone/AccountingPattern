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
    var _accounts = Dictionary<UUID, Account>()

    public var accounts: [Account] {
        get {
            return Array(_accounts.values)
        }
    }
    
    public init() {
    }

    // MARK: Accessing and managing accounts

    public var count: Int {
        return _accounts.count
    }
    
    public subscript(index: UUID, includeHidden: Bool = false) -> Account? {
        get {
            guard let account = _accounts[index] else {
                return nil
            }
            guard (account.hidden && includeHidden) || !account.hidden else {
                return nil
            }
            return account
        }
        set(newValue) {
            let account = _accounts[index]
            if account == nil || ((account!.hidden && includeHidden) || !account!.hidden) {
                _accounts[index] = newValue
            }
        }
    }
    
    func addAccount(name: String, type: AccountType, number: AccountNumber, currency: CurrencyType = CurrencyType.currencyForDefaultLocale(), entries: Set<Entry> = Set<Entry>()) throws {
        let account = Account(name: name, type: type, number: number, currency: currency, entries: entries)
        try addAccount(account)
    }
    
    func addAccount(_ account: Account) throws {
        if (_accounts[account.id] != nil) {
            throw ChartOfAccountsError.accountAlreadyExists
        } else {
            _accounts[account.id] = account
        }
    }
    
    func updateAccount(_ account: Account) throws {
        guard _accounts.contains(where: { $0.key == account.id }) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        _accounts[account.id] = account
    }
    
    func deleteAccount(_ account: Account) throws {
        guard _accounts.contains(where: { $0.value.id == account.id }) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        _accounts.removeValue(forKey: account.id)
    }
    
    func hideAccount(_ account: Account) throws {
        guard _accounts.contains(where: { $0.value.id == account.id }) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        _accounts[account.id]!.hidden = true
    }
    
    public func accountsSorted(_ order: SortOrderType, includeHidden: Bool = false) -> [(key: UUID, value: Account)] {
        return _accounts.filter({ $0.value.hidden && includeHidden || !$0.value.hidden }).sorted(by: { order == SortOrderType.ascending ? $0.value.name < $1.value.name : $0.value.name > $1.value.name })
        }
    
    // MARK: Managing tags
    
    public func addTag(_ tag: String, forAccount: Account, withCategory category: String = "") throws {
        guard _accounts.contains(where: { $0.value.id == forAccount.id }) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        _accounts[forAccount.id]!.addTag(tag, forCategory: category)
    }
    
    public func removeTag(_ tag: String, forAccount: Account, withCategory category: String = "") throws {
        guard _accounts.contains(where: { $0.value.id == forAccount.id }) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        try _accounts[forAccount.id]!.removeTag(tag, forCategory: category)
    }
    
    public func hasTag(_ tag: String, forAccount: Account, withCategory category: String = "") throws -> Bool {
        guard _accounts.contains(where: { $0.value.id == forAccount.id }) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        return _accounts[forAccount.id]!.hasTag(tag, forCategory: category)
    }
    
    public func removeAllTagsForAccount(_ account: Account) throws {
        guard _accounts.contains(where: { $0.value.id == account.id }) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        _accounts[account.id]!.removeAllTags()
    }
       
    public func removeAllTagsForAccount(_ account: Account, withCategory category: String = "") throws {
        guard _accounts.contains(where: { $0.value.id == account.id }) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        try _accounts[account.id]!.removeAllTagsForCategory(category)
    }
    
    public subscript(index: String, forCategory category: String = "", includeHidden: Bool = false) -> [Account] {
        get {
            return _accounts.filter({ ($0.value.hidden && includeHidden || !$0.value.hidden) && $0.value.hasTag(index, forCategory: category) }).map( {$0.value} )
        }
    }
    
    // MARK: Managing entries
    
    // TODO: Add unit test coverage
    public func addEntry(_ entry: Entry, forAccountId accountId: UUID) throws {
        try _accounts[accountId]?.addEntry(entry)
    }
}
