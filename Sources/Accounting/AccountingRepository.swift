//
//  AccountingRepository.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/28/20.
//

import Foundation

public class AccountingRepository {
    public let chartOfAccounts: ChartOfAccounts
    private let rulesRepository: RulesRepository
    
    /**
     - Note: TODO we want to make this more extensible then initializing in init, but this will work for now.
     */
    public init() throws {
        self.chartOfAccounts = ChartOfAccounts()
        self.rulesRepository = RulesRepository()
        try self.rulesRepository.addPostingRule(AccountPostingRule(), forEventType: AccountingEvent.POSTING_EVENT_TYPE)
    }
    
    public func addAccount(name: String, number: AccountNumber, balanceDate: Date = Date(), openingBalance: Decimal = 0.0,  currency: CurrencyType = CurrencyType.currencyForDefaultLocale()) throws {
        let account = Account(name: name, number: number, currency: CurrencyType.currencyForDefaultLocale())
        var event = AccountingEvent(name: "Opening Balance", whenOccurred: balanceDate, whenNoticed: nil, isProcessed: false, otherParty: OtherParty(name: "Opening Balance"), amount: Money(openingBalance, currency), account: account, entryType: EntryType.debit, note: "Opening Balance")
        try rulesRepository.processEvent(&event)
        try chartOfAccounts.addAccount(event.account)
     }
}
