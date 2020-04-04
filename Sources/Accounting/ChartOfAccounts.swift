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
        case accountAlreadyExists
        case cantFindAccount
    }
    
    var accounts = Dictionary<UUID, Account>()
    
    public var count: Int {
        return accounts.count
    }
        
    public init() {
    }

    subscript(index: UUID, includeHidden: Bool = false) -> Account? {
        get {
            guard let account = accounts[index] else {
                return nil
            }
            guard (account.hidden && includeHidden) || !account.hidden else {
                return nil
            }
            return account
        }
        set(newValue) {
            let account = accounts[index]
            if account == nil || ((account!.hidden && includeHidden) || !account!.hidden) {
                accounts[index] = newValue
            }
        }
    }
    
    public func addAccount(name: String, type: AccountType, number: AccountNumber, currency: CurrencyType = CurrencyType.currencyForDefaultLocale(), entries: Set<Entry> = Set<Entry>()) throws {
        let account = Account(name: name, type: type, number: number, currency: currency, entries: entries)
        try addAccount(account)
    }
    
    public func addAccount(_ account: Account) throws {
        if (accounts[account.id] != nil) {
            throw ChartOfAccountsError.accountAlreadyExists
        } else {
            accounts[account.id] = account
        }
    }
    
    public func updateAccount(_ account: Account) throws {
        guard accounts.contains(where: { $0.key == account.id }) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        accounts[account.id] = account
    }
    
    public func deleteAccount(_ account: Account) throws {
        guard accounts.contains(where: { $0.value.id == account.id }) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        accounts.removeValue(forKey: account.id)
    }
    
    public func hideAccount(_ account: Account) throws {
        guard accounts.contains(where: { $0.value.id == account.id }) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        accounts[account.id]!.hidden = true
    }
    
    public func addTag(_ tag: String, forAccount: Account, withCategory: String = "") throws {
        guard accounts.contains(where: { $0.value.id == forAccount.id }) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        accounts[forAccount.id]!.addTag(tag, forCategory: withCategory)
    }
    
    public func removeTag(_ tag: String, forAccount: Account, withCategory: String = "") throws {
        guard accounts.contains(where: { $0.value.id == forAccount.id }) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        try accounts[forAccount.id]!.removeTag(tag, forCategory: withCategory)
    }
    
    public func hasTag(_ tag: String, forAccount: Account, withCategory: String = "") throws -> Bool {
        guard accounts.contains(where: { $0.value.id == forAccount.id }) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        return accounts[forAccount.id]!.hasTag(tag, forCategory: withCategory)
    }
    
    public func removeAllTagsForAccount(_ account: Account) throws {
        guard accounts.contains(where: { $0.value.id == account.id }) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        accounts[account.id]!.removeAllTags()
    }
       
    public func removeAllTagsForAccount(_ account: Account, forCategory: String) throws {
        guard accounts.contains(where: { $0.value.id == account.id }) else {
            throw ChartOfAccountsError.cantFindAccount
        }
        try accounts[account.id]!.removeAllTagsForCategory(forCategory)
    }

    public func accountsSorted(_ order: SortOrderType, includeHidden: Bool = false) -> [(key: UUID, value: Account)] {
        return accounts.filter({ $0.value.hidden && includeHidden || !$0.value.hidden }).sorted(by: { order == SortOrderType.ascending ? $0.value.name < $1.value.name : $0.value.name > $1.value.name })
        }
}
