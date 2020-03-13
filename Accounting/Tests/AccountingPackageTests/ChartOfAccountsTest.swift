//
//  ChartOfAccountsTest.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/10/20.
//

import Foundation

import XCTest
@testable import AccountingPackage
import Mockingbird

final class ChartOfAccountsTest: XCTestCase {
    var COA: ChartOfAccounts!
    
    override func setUp() {
        COA = ChartOfAccounts()
    }
    
    func testAddingAccounts() {
        //let accountmock = mock(Account.self)
        XCTAssertNoThrow(try COA.addAccountWith(name: "First Account", number: AccountNumber("12345"), currency: .USD))
        XCTAssertEqual(1, COA.count)
        let account = Account(name: "Second Account", number: AccountNumber("67890"), currency: .USD)
        XCTAssertNoThrow(try COA.addAccount(account))
        XCTAssertEqual(2, COA.count)
    }
    
    func testAddingAccountAlreadyExists() {
        XCTAssertNoThrow(try COA.addAccountWith(name: "First Account", number: AccountNumber("12345"), currency: .USD))
        XCTAssertEqual(1, COA.count)
        XCTAssertThrowsError(try COA.addAccountWith(name: "First Account", number: AccountNumber("12345"), currency: .USD), "Should have thrown \(ChartOfAccounts.ChartOfAccountsError.accountAlreadyInList)") {
            (error) in
            XCTAssertEqual(error as? ChartOfAccounts.ChartOfAccountsError, ChartOfAccounts.ChartOfAccountsError.accountAlreadyInList)
        }
    }
    
    func testCount() {
        XCTAssertEqual(0, COA.count)
        
    }
    
    func testSubscript() {
        XCTAssertNil(COA["Account 1"])
        let account = Account(name: "Account", number: AccountNumber("67890"), currency: .USD)
        XCTAssertNoThrow(try COA.addAccount(account))
        XCTAssertEqual(account, COA[account.name])
    }
    
    func testAccountNamesSorted() {
        XCTAssertNoThrow(try COA.addAccountWith(name: "ABCD", number: AccountNumber("12345"), currency: .USD))
        XCTAssertNoThrow(try COA.addAccountWith(name: "ACD", number: AccountNumber("12345"), currency: .USD))
        XCTAssertNoThrow(try COA.addAccountWith(name: "ABCA", number: AccountNumber("12345"), currency: .USD))
        //var (accountNames, accounts) = COA.accountsSorted(.ascending)
//        XCTAssertEqual("ABCA", accountNames[0])
//        XCTAssertEqual("ABCD", accountNames[1])
//        XCTAssertEqual("ACD", accountNames[2])
    }
    
    static var allTests = [
        ("testAddingAccounts", testAddingAccounts),
        ("testAddingAccounts", testAddingAccountAlreadyExists),
    ]
}
