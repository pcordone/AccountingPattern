//
//  AccountingRepositoryTest.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/28/20.
//

import XCTest
@testable import Accounting

final class AccountingFacadeTest: XCTestCase {
    var accountingFacade: AccountingFacade!
    
    override func setUp() {
        XCTAssertNoThrow(accountingFacade = AccountingFacade())
    }
    
    func testAddAccount() {
        let now = Date()
        XCTAssertEqual(0, accountingFacade.chartOfAccounts.count)
        XCTAssertNoThrow(try accountingFacade.addAccount(name: "Test Account", type: .asset, number: AccountNumber("12345"), balanceDate: now, openingBalance: 1000, currency: CurrencyType.currencyForDefaultLocale()))
        let account = accountingFacade.chartOfAccounts.accounts.first ?? nil
        XCTAssertNotNil(account)
        XCTAssertNotNil(account!.id)
        XCTAssertEqual("Test Account", account!.name)
        XCTAssertEqual(.asset, account!.type)
        XCTAssertEqual("12345", account!.number.number)
        XCTAssertEqual(CurrencyType.currencyForDefaultLocale(), account!.currency)
        XCTAssertFalse(account!.hidden)
        XCTAssertTrue(account!.tags.isEmpty)
        let entry = account!.entries.first
        XCTAssertNotNil(entry)
        XCTAssertEqual(1000, entry!.amount)
        XCTAssertEqual(now, entry!.date)
        XCTAssertEqual(.debit, entry!.type)
        XCTAssertEqual("Opening Balance", entry!.otherParty.name)
        XCTAssertEqual("Opening Balance", entry!.note)
    }
    
    func testUpdateAccount() {
        XCTAssertEqual(0, accountingFacade.chartOfAccounts.count)
        var account = Account(name: "Account Name", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertEqual(.USD, account.currency)
        XCTAssertEqual("Account Name", account.name)
        XCTAssertEqual("123456", account.number.number)
        XCTAssertEqual(.asset, account.type)
        XCTAssertEqual(false, account.hidden)
        XCTAssertNil(account.entries.first)
        XCTAssertNoThrow(try accountingFacade.addAccount(account))
        account.name = "Account Name Modified"
        account.hidden = true
        XCTAssertNoThrow(try accountingFacade.updateAccount(account))
        let modifiedAccount = accountingFacade.chartOfAccounts.accounts.first
        XCTAssertEqual(.USD, modifiedAccount?.currency)
        XCTAssertEqual("Account Name Modified", modifiedAccount?.name)
        XCTAssertEqual("123456", modifiedAccount?.number.number)
        XCTAssertEqual(.asset, modifiedAccount?.type)
        XCTAssertTrue(modifiedAccount?.hidden ?? false)
        XCTAssertNil(modifiedAccount?.entries.first)
    }
    
    func testDeleteAccount() {
        XCTAssertEqual(0, accountingFacade.chartOfAccounts.count)
        let account = Account(name: "Account Name", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertNoThrow(try accountingFacade.addAccount(account))
        XCTAssertTrue(accountingFacade.chartOfAccounts.accounts.contains(where: { $0.id == account.id }))
        XCTAssertNoThrow(try accountingFacade.deleteAccount(account))
        XCTAssertFalse(accountingFacade.chartOfAccounts.accounts.contains(where: { $0.id == account.id }))
    }
    
    func testProcessEvent() {
        let account = Account(name: "Account Name", type: .asset, number: AccountNumber("123456"))
        XCTAssertNoThrow(try accountingFacade.addAccount(account))
        XCTAssertEqual(account.id, accountingFacade.chartOfAccounts.accounts.first?.id)
        XCTAssertNoThrow(try accountingFacade.processAccountingEvent(name: "Debit", whenOccured: Date(), whenNoticed: nil, otherParty: OtherParty(name: "Other Party"), amount: 1000, account: account, entryType: .debit))
        XCTAssertEqual(account.id, accountingFacade.chartOfAccounts.accounts.first?.id)
        XCTAssertEqual(1, accountingFacade.chartOfAccounts.accounts.first?.entries.count)
        XCTAssertEqual(1000, accountingFacade.chartOfAccounts.accounts.first?.entries.first?.amount)
    }
        
    static var allTests = [
        ("testAddAccount", testAddAccount),
        ("testUpdateAccount", testUpdateAccount),
        ("testDeleteAccount", testDeleteAccount),
    ]
}

