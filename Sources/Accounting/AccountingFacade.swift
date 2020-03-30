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
        case triedToAddEventThatAlreadyExists
    }
    
    public let chartOfAccounts = ChartOfAccounts()
    private let rulesRepository = RulesRepository()
    private var events = OrderedArray<AccountingEvent>(allowDuplicates: false)
    
    /**
     - Note: TODO we want to make this more extensible then initializing in init, but this will work for now.
     */
    public init() {
        try! self.rulesRepository.addPostingRule(AccountPostingRule(), forEventType: AccountingEvent.POSTING_EVENT_TYPE)
    }
    
    public func addAccount(name: String, type: AccountType, number: AccountNumber, balanceDate: Date = Date(), openingBalance: Decimal = 0.0,  currency: CurrencyType = CurrencyType.currencyForDefaultLocale()) throws {
        var event = AccountingEvent(name: "Opening Balance", whenOccurred: balanceDate, whenNoticed: nil, isProcessed: false, otherParty: OtherParty(name: "Opening Balance"), amount: Money(openingBalance, currency), account: Account(name: name, type: type, number: number, currency: currency), entryType: EntryType.debit, note: "Opening Balance")
        try rulesRepository.processEvent(&event)
        let (existing, _) = events.insert(event)
        guard existing == false else {
            throw AccountingFacade.Errors.triedToAddEventThatAlreadyExists
        }
        try chartOfAccounts.addAccount(event.account)
     }
    
    public func processEvent(_ event: AccountingEvent) {
        
    }
}
