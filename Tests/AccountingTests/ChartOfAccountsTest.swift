//
//  ChartOfAccountsTest.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/10/20.
//

import Foundation

import XCTest
@testable import Accounting

import Mockingbird

final class ChartOfAccountsTest: XCTestCase {
    var COA: ChartOfAccounts!
    
    override func setUp() {
        COA = ChartOfAccounts()
    }
    
    func testAddingAccounts() {
        XCTAssertNoThrow(try COA.addAccount(name: "First Account", type: .asset, number: AccountNumber("12345"), currency: .USD))
        XCTAssertEqual(1, COA.count)
        //let accountmock = mock(Account.self)
        let account = Account(name: "Second Account", type: .asset, number: AccountNumber("67890"), currency: .USD)
        XCTAssertNoThrow(try COA.addAccount(account))
        XCTAssertEqual(2, COA.count)
    }
    
    func testAddingAccountAlreadyExists() {
        XCTAssertNoThrow(try COA.addAccount(name: "First Account", type: .asset, number: AccountNumber("12345"), currency: .USD))
        XCTAssertEqual(1, COA.count)
        let (id, COAAccount) = COA.accounts.first ?? (nil, nil)
        XCTAssertNotNil(id)
        XCTAssertNotNil(COAAccount)
        let account = Account(name: "Second account with same id as first", type: .asset, number: AccountNumber("7890"), currency: .USD, id: id!)
        XCTAssertThrowsError(try COA.addAccount(account), "Should have thrown \(ChartOfAccounts.ChartOfAccountsError.accountAlreadyExists)") {
            (error) in
            XCTAssertEqual(error as? ChartOfAccounts.ChartOfAccountsError, ChartOfAccounts.ChartOfAccountsError.accountAlreadyExists)
        }
    }
    
    func testUpdateAccount() {
        var account = Account(name: "Name", type: .asset, number: AccountNumber("12345"), currency: .USD)
        XCTAssertNoThrow(try COA.addAccount(account))
        account.name = "New Name"
        XCTAssertNoThrow(try COA.updateAccount(account))
        XCTAssertEqual("New Name", account.name)
    }
    
    func testDeleteAccount() {
        let account = Account(name: "Name", type: .asset, number: AccountNumber("12345"), currency: .USD)
        XCTAssertNoThrow(try COA.addAccount(account))
        XCTAssertNoThrow(try COA.deleteAccount(account))
        XCTAssertNil(COA.accounts[account.id])
    }

    func testHideAccount() {
        let account = Account(name: "Name", type: .asset, number: AccountNumber("12345"), currency: .USD)
        XCTAssertNoThrow(try COA.addAccount(account))
        XCTAssertNoThrow(try COA.hideAccount(account))
        XCTAssertNotNil(COA.accounts[account.id])
        XCTAssertNil(COA[account.id])
        XCTAssertNotNil(COA[account.id, true])
    }
    
    func testCount() {
        XCTAssertEqual(0, COA.count)
    }
    
    func testSubscript() {
        let id = UUID()
        XCTAssertNil(COA[id])
        let account = Account(name: "Account", type: .asset, number: AccountNumber("67890"), currency: .USD, id: id)
        XCTAssertNoThrow(try COA.addAccount(account))
        XCTAssertEqual(account, COA[id])
    }
    
//    func testAccountNamesSorted() {
//        XCTAssertNoThrow(try COA.addAccount(name: "ABCD", type: .expense, number: AccountNumber("12345"), currency: .USD))
//        XCTAssertNoThrow(try COA.addAccount(name: "ACD", type: .expense, number: AccountNumber("12345"), currency: .USD))
//        XCTAssertNoThrow(try COA.addAccount(name: "ABCA", type: .expense, number: AccountNumber("12345"), currency: .USD))
//        var (accountNames, accounts) = COA.accountsSorted(.ascending)
//        XCTAssertEqual("ABCA", accountNames[0])
//        XCTAssertEqual("ABCD", accountNames[1])
//        XCTAssertEqual("ACD", accountNames[2])
//    }
    
    static var allTests = [
        ("testAddingAccounts", testAddingAccounts),
        ("testAddingAccounts", testAddingAccountAlreadyExists),
        ("testUpdateAccount", testUpdateAccount),
        ("testDeleteAccount", testDeleteAccount),
        ("testHideAccount", testHideAccount),
        ("testCount", testCount),
        ("testSubscript", testSubscript),
    ]
}
