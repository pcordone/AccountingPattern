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
     - Note: TODO we want to make this more extensible then initializing in init, but this will work for now.
     */
    public init() {
        try! self.rulesRepository.addPostingRule(AccountPostingRule(), forEventType: AccountingEvent.POSTING_EVENT_TYPE)
    }
    
    public func addAccount(name: String, type: AccountType, number: AccountNumber, balanceDate: Date = Date(), openingBalance: Decimal = 0.0,  currency: CurrencyType = CurrencyType.currencyForDefaultLocale()) throws {
        let event = AccountingEvent(name: "Opening Balance", whenOccurred: balanceDate, whenNoticed: nil, isProcessed: false, otherParty: OtherParty(name: "Opening Balance"), amount: Money(openingBalance, currency), account: Account(name: name, type: type, number: number, currency: currency), entryType: EntryType.debit, note: "Opening Balance")
        try chartOfAccounts.addAccount(rulesRepository.processEvent(event).account)
     }
    
    public func updateAccount(_ account: Account) throws {
        try chartOfAccounts.updateAccount(account)
    }
    
    func deleteAccount(_ account: Account) throws {
        try chartOfAccounts.deleteAccount(account)
    }
    
    func hideAccount(_ account: Account) throws {
        try chartOfAccounts.hideAccount(account)
    }
}
