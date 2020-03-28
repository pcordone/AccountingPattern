//
//  AccountingRepositoryTest.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/28/20.
//

import XCTest
@testable import Accounting

final class AccountingRepositoryTest: XCTestCase {
    var accountingRepository: AccountingRepository!
    
    override func setUp() {
        XCTAssertNoThrow(try accountingRepository = AccountingRepository())
    }
    
    func testAddAccount() {
        let now = Date()
        XCTAssertEqual(0, accountingRepository.chartOfAccounts.count)
        XCTAssertNoThrow(try accountingRepository.addAccount(name: "Test Account", number: AccountNumber("12345"), balanceDate: now, openingBalance: 1000))
        let account = accountingRepository.chartOfAccounts["Test Account"]
        XCTAssertNotNil(account)
        XCTAssertEqual("12345", account?.number.number)
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

