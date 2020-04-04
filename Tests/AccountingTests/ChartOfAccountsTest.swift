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
    
    func testAccountNamesSorted() {
        XCTAssertNoThrow(try COA.addAccount(name: "ABCD", type: .expense, number: AccountNumber("12345"), currency: .USD))
        XCTAssertNoThrow(try COA.addAccount(name: "ACD", type: .expense, number: AccountNumber("12345"), currency: .USD))
        XCTAssertNoThrow(try COA.addAccount(name: "ABCA", type: .expense, number: AccountNumber("12345"), currency: .USD))
        var results = COA.accountsSorted(.ascending)
        XCTAssertEqual("ABCA", results[0].value.name)
        XCTAssertEqual("ABCD", results[1].value.name)
        XCTAssertEqual("ACD", results[2].value.name)
        XCTAssertNoThrow(try COA.hideAccount(results[0].value))
        results = COA.accountsSorted(.ascending)
        XCTAssertEqual("ABCD", results[0].value.name)
        XCTAssertEqual("ACD", results[1].value.name)
        results = COA.accountsSorted(.ascending, includeHidden: true)
        XCTAssertEqual("ABCA", results[0].value.name)
        XCTAssertEqual("ABCD", results[1].value.name)
        XCTAssertEqual("ACD", results[2].value.name)
    }
    
    func testAddTag() {
        let account = Account(name: "Account One", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        let account2 = Account(name: "Account Two", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertNoThrow(try COA.addAccount(account))
        XCTAssertNoThrow(try COA.addAccount(account2))
        XCTAssertTrue(COA[account.id]?.tags.isEmpty ?? false)
        XCTAssertTrue(COA[account2.id]?.tags.isEmpty ?? false)
        XCTAssertNoThrow(try COA.addTag("Tag", forAccount: account))
        XCTAssertTrue(COA[account.id]?.tags[""]?.contains("Tag") ?? false)
        XCTAssertTrue(COA[account2.id]?.tags.isEmpty ?? false)
        XCTAssertNoThrow(try COA.addTag("Tag 2", forAccount: account2, withCategory: "Category"))
        XCTAssertFalse(COA[account.id]?.tags["Category"]?.contains("Tag 2") ?? false)
        XCTAssertFalse(COA[account.id]?.tags[""]?.contains("Tag 2") ?? false)
    }
    
    func testRemoveTag() {
        let account = Account(name: "Account One", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        let account2 = Account(name: "Account Two", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertNoThrow(try COA.addAccount(account))
        XCTAssertNoThrow(try COA.addAccount(account2))
        XCTAssertTrue(COA[account.id]?.tags.isEmpty ?? false)
        XCTAssertTrue(COA[account2.id]?.tags.isEmpty ?? false)
        XCTAssertNoThrow(try COA.addTag("Tag", forAccount: account))
        XCTAssertTrue(COA[account.id]?.tags[""]?.contains("Tag") ?? false)
        XCTAssertNoThrow(try COA.addTag("Tag 2", forAccount: account2, withCategory: "Category"))
        XCTAssertTrue(COA[account2.id]?.tags["Category"]?.contains("Tag 2") ?? false)
        XCTAssertNoThrow(try COA.removeTag("Tag", forAccount: account))
        XCTAssertTrue(COA[account.id]?.tags[""]?.isEmpty ?? false)
        XCTAssertNoThrow(try COA.removeTag("Tag 2", forAccount: account2, withCategory: "Category"))
        XCTAssertTrue(COA[account2.id]?.tags["Category"]?.isEmpty ?? false)
    }
    
    func testHasTag() {
        let account = Account(name: "Account One", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        let account2 = Account(name: "Account Two", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertNoThrow(try COA.addAccount(account))
        XCTAssertNoThrow(try COA.addAccount(account2))
        XCTAssertTrue(COA[account.id]?.tags.isEmpty ?? false)
        XCTAssertTrue(COA[account2.id]?.tags.isEmpty ?? false)
        XCTAssertFalse(try COA.hasTag("Tag", forAccount: account))
        XCTAssertFalse(try COA.hasTag("Tag 2", forAccount: account2, withCategory: "Category"))
        XCTAssertNoThrow(try COA.addTag("Tag", forAccount: account))
        XCTAssertTrue(try COA.hasTag("Tag", forAccount: account))
        XCTAssertFalse(try COA.hasTag("Tag", forAccount: account, withCategory: "Category"))
        XCTAssertNoThrow(try COA.addTag("Tag 2", forAccount: account2, withCategory: "Category"))
        XCTAssertTrue(try COA.hasTag("Tag 2", forAccount: account2, withCategory: "Category"))
        XCTAssertFalse(try COA.hasTag("Tag", forAccount: account2))
    }
    
    func testRemoveAllTagsForCategory() {
        let account = Account(name: "Account One", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        let account2 = Account(name: "Account Two", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertNoThrow(try COA.addAccount(account))
        XCTAssertNoThrow(try COA.addTag("Tag", forAccount: account))
        XCTAssertNoThrow(try COA.addAccount(account2))
        XCTAssertNoThrow(try COA.addTag("Tag 2", forAccount: account2, withCategory: "Category"))
        XCTAssertTrue(COA[account.id]?.tags[""]?.contains("Tag") ?? false)
        XCTAssertTrue(COA[account2.id]?.tags["Category"]?.contains("Tag 2") ?? false)
        XCTAssertNoThrow(try COA.removeAllTagsForAccount(account))
        XCTAssertTrue(COA[account.id]?.tags.isEmpty ?? false)
        XCTAssertNoThrow(try COA.removeAllTagsForAccount(account2))
        XCTAssertTrue(COA[account2.id]?.tags.isEmpty ?? false)
    }
    
    static var allTests = [
        ("testAddingAccounts", testAddingAccounts),
        ("testAddingAccounts", testAddingAccountAlreadyExists),
        ("testUpdateAccount", testUpdateAccount),
        ("testDeleteAccount", testDeleteAccount),
        ("testHideAccount", testHideAccount),
        ("testCount", testCount),
        ("testSubscript", testSubscript),
        ("testAccountNamesSorted", testAccountNamesSorted),
        ("testAccountNamesSorted", testAccountNamesSorted),
        ("testAddTag", testAddTag),
        ("testRemoveTag", testRemoveTag),
        ("testHasTag", testHasTag),
        ("testRemoveAllTagsForCategory", testRemoveAllTagsForCategory),
    ]
}
