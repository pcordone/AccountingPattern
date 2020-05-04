//
//  ChartOfAccountsTest.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/10/20.
//

import Foundation

import XCTest
import Combine
@testable import Accounting

final class ChartOfAccountsTest: XCTestCase {
    var COA: ChartOfAccounts!
    var subscriptions = Set<AnyCancellable>()
    var accounts = Set<Account>()
  
    override func setUp() {
        COA = ChartOfAccounts()
        COA.$accounts.assign(to: \.accounts, on: self).store(in: &subscriptions)
    }
    
    // MARK: Account management tests
    
    func testAddingAccounts() {
        XCTAssertTrue(accounts.isEmpty)
        XCTAssertNoThrow(try COA.addAccount(name: "First Account", type: .asset, number: AccountNumber("12345"), currency: .USD))
        XCTAssertEqual(1, COA.count)
        XCTAssertEqual(COA.accounts, accounts)
        //let accountmock = mock(Account.self)
        let account = Account(name: "Second Account", type: .asset, number: AccountNumber("67890"), currency: .USD)
        XCTAssertNoThrow(try COA.addAccount(account))
        XCTAssertEqual(2, COA.count)
        XCTAssertEqual(COA.accounts, accounts)
    }
    
    func testAddingAccountAlreadyExists() {
        XCTAssertNoThrow(try COA.addAccount(name: "First Account", type: .asset, number: AccountNumber("12345"), currency: .USD))
        XCTAssertEqual(1, COA.count)
        XCTAssertEqual(COA.accounts, accounts)
        let COAAccount = COA.accounts.first
        XCTAssertNotNil(COAAccount)
        let account = Account(name: "Second account with same id as first", type: .asset, number: AccountNumber("7890"), currency: .USD, id: COAAccount!.id)
        XCTAssertThrowsError(try COA.addAccount(account), "Should have thrown \(ChartOfAccountsError.accountAlreadyExists)") {
            (error) in
            XCTAssertEqual(error as? ChartOfAccountsError, ChartOfAccountsError.accountAlreadyExists)
        }
        XCTAssertEqual(COA.accounts, accounts)
    }
    
    func testUpdateAccount() {
        var account = Account(name: "Name", type: .asset, number: AccountNumber("12345"), currency: .USD)
        XCTAssertNoThrow(try COA.addAccount(account))
        account.name = "New Name"
        XCTAssertNoThrow(try COA.updateAccount(account))
        XCTAssertEqual("New Name", account.name)
        XCTAssertEqual(COA.accounts, accounts)
    }
    
    func testDeleteAccount() {
        let account = Account(name: "Name", type: .asset, number: AccountNumber("12345"), currency: .USD)
        XCTAssertNoThrow(try COA.addAccount(account))
        XCTAssertNoThrow(try COA.deleteAccount(account))
        XCTAssertFalse(COA.accounts.contains(account))
        XCTAssertEqual(COA.accounts, accounts)
    }
    
    func testCount() {
        XCTAssertEqual(0, COA.count
    }
    
    func testAccountNamesSorted() {
        XCTAssertNoThrow(try COA.addAccount(name: "ABCD", type: .expense, number: AccountNumber("12345"), currency: .USD))
        XCTAssertNoThrow(try COA.addAccount(name: "ACD", type: .expense, number: AccountNumber("12345"), currency: .USD))
        XCTAssertNoThrow(try COA.addAccount(name: "ABCA", type: .expense, number: AccountNumber("12345"), currency: .USD))
        var results = COA.accountsSorted(.ascending)
        XCTAssertEqual("ABCA", results[0].name)
        XCTAssertEqual("ABCD", results[1].name)
        XCTAssertEqual("ACD", results[2].name)
        var account = results[0]
        account.hidden = true
        XCTAssertNoThrow(try COA.updateAccount(account))
        results = COA.accountsSorted(.ascending)
        XCTAssertEqual("ABCD", results[0].name)
        XCTAssertEqual("ACD", results[1].name)
        results = COA.accountsSorted(.ascending, includeHidden: true)
        XCTAssertEqual("ABCA", results[0].name)
        XCTAssertEqual("ABCD", results[1].name)
        XCTAssertEqual("ACD", results[2].name)
    }
    
    // MARK: Test tag management methods
    
    func testAccountTagSubscript() {
        XCTAssertTrue(COA["Tag Name", forCategory: "Category Name"].isEmpty)
        var account = Account(name: "Account One", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        account.addTag("Tag Name")
        XCTAssertNoThrow(try COA.addAccount(account))
        let accountsForTag = COA["Tag Name"]
        XCTAssertEqual(account, accountsForTag[0])
    }
    
    static var allTests = [
        ("testAddingAccounts", testAddingAccounts),
        ("testAddingAccounts", testAddingAccountAlreadyExists),
        ("testUpdateAccount", testUpdateAccount),
        ("testDeleteAccount", testDeleteAccount),
        ("testCount", testCount),
        ("testAccountNamesSorted", testAccountNamesSorted),
        ("testAccountNamesSorted", testAccountNamesSorted),
        ("testAccountTagSubscript", testAccountTagSubscript),
    ]
}
