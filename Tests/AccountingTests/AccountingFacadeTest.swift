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
        let (id, account) = accountingFacade.chartOfAccounts.accounts.first ?? (nil, nil)
        XCTAssertNotNil(id)
        XCTAssertNotNil(account)
        XCTAssertEqual(id!, account!.id)
        XCTAssertEqual("12345", account!.number.number)
        let entry = account!.entries.first
        XCTAssertNotNil(entry)
        XCTAssertEqual(1000, entry!.amount)
        XCTAssertEqual(now, entry!.date)
        XCTAssertEqual(.debit, entry!.entryType)
        XCTAssertEqual("Opening Balance", entry!.otherParty.name)
        XCTAssertEqual("Opening Balance", entry!.note)
    }
    
    static var allTests = [
        ("testAddAccount", testAddAccount),
    ]
}

