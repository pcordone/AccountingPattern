//
//  AccountingRepository.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/28/20.
//

import Foundation
import SwiftAlgorithmClub

public class AccountingFacade {
    public enum Errors: Error {
        case triedToUpdateAnAccountThatDoesntExist
    }
    
    public let chartOfAccounts = ChartOfAccounts()
    private let rulesRepository = RulesRepository()
    
    /**
     TODO: We want to make this more extensible then initializing in init, but this will work for now.
     */
    public init() {
        try! self.rulesRepository.addPostingRule(AccountPostingRule(), forEventType: AccountingEvent.POSTING_EVENT_TYPE)
    }
    
    // MARK: Event
    // TODO: I need to add event processing methods to this facade.
    
    // MARK: Account maintenance methods
    
    public func addAccount(_ account: Account, balanceDate: Date = Date(), openingBalance: Decimal = 0.0,  currency: CurrencyType = CurrencyType.currencyForDefaultLocale()) throws {
        let event = AccountingEvent(name: "Opening Balance", whenOccurred: balanceDate, whenNoticed: nil, isProcessed: false, otherParty: OtherParty(name: "Opening Balance"), amount: Money(openingBalance, currency), account: account, entryType: EntryType.debit, note: "Opening Balance")
               try chartOfAccounts.addAccount(rulesRepository.processEvent(event).account)
    }
    
    public func addAccount(name: String, type: AccountType, number: AccountNumber, balanceDate: Date = Date(), openingBalance: Decimal = 0.0,  currency: CurrencyType = CurrencyType.currencyForDefaultLocale()) throws {
        try addAccount(Account(name: name, type: type, number: number, currency: currency), balanceDate: balanceDate, openingBalance: openingBalance, currency: currency)
     }
    
    public func updateAccount(_ account: Account) throws {
        // TODO: Do I need to capture an event for updating an account?
        try chartOfAccounts.updateAccount(account)
    }
    
    public func deleteAccount(_ account: Account) throws {
        // TODO: Do I need to capture an event for updating an account?
        try chartOfAccounts.deleteAccount(account)
    }
    
    public func hideAccount(_ account: Account) throws {
        // TODO: Do I need to capture an event for updating an account?
        try chartOfAccounts.hideAccount(account)
    }
    
    // MARK: Event methods
    
    public func processAccountingEvent(_ event: AccountingEvent) throws {
        // TODO: Need to store the processed events.  Disregarding result for now.
        guard chartOfAccounts[event.account.id] != nil else {
            throw ChartOfAccountsError.cantFindAccount
        }
        try chartOfAccounts.updateAccount(rulesRepository.processEvent(event).account)
    }
    
    public func processAccountingEvent(name: String, whenOccured: Date, whenNoticed: Date?, otherParty: OtherParty, amount: Money, account: Account, entryType: EntryType) throws {
        let event = AccountingEvent(name: name, whenOccurred: whenOccured, whenNoticed: whenNoticed, isProcessed: false, otherParty: otherParty, amount: amount, account: account, entryType: entryType)
        try processAccountingEvent(event)
    }
    
    // MARK: Account tagging methods
    
    public func addTag(_ tag: String, forAccount account: Account, withCategory category: String = "") throws {
        // TODO: Do I need to capture an event for updating an account?
        try chartOfAccounts.addTag(tag, forAccount: account, withCategory: category)
    }
    
    public func removeTag(_ tag: String, forAccount account: Account, withCategory category: String = "") throws {
        // TODO: Do I need to capture an event for updating an account?
        try chartOfAccounts.removeTag(tag, forAccount: account, withCategory: category)
    }

    public func removeAllTagsForAccount(_ account: Account) throws {
        // TODO: Do I need to capture an event for updating an account?
        try chartOfAccounts.removeAllTagsForAccount(account)
    }
    
    public func removeAllTagsForAccount(_ account: Account, withCategory category: String = "") throws {
        // TODO: Do I need to capture an event for updating an account?
        try chartOfAccounts.removeAllTagsForAccount(account, withCategory: category)
    }
}
