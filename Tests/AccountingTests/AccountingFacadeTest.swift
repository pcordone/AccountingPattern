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
        let modifiedAccount = accountingFacade.chartOfAccounts[account.id, true]
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
        XCTAssertTrue(accountingFacade.chartOfAccounts.accounts.contains(where: { $0.key == account.id }))
        XCTAssertNoThrow(try accountingFacade.deleteAccount(account))
        XCTAssertFalse(accountingFacade.chartOfAccounts.accounts.contains(where: { $0.key == account.id }))
    }
    
    func testHideAccount() {
        XCTAssertEqual(0, accountingFacade.chartOfAccounts.count)
        let account = Account(name: "Account Name", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertNoThrow(try accountingFacade.addAccount(account))
        XCTAssertTrue(accountingFacade.chartOfAccounts.accounts.contains(where: { $0.key == account.id }))
        XCTAssertNoThrow(try accountingFacade.hideAccount(account))
    }
    
    func testAddTag() {
        let account = Account(name: "Account Name", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertNoThrow(try accountingFacade.addAccount(account))
        XCTAssertTrue(accountingFacade.chartOfAccounts.accounts.contains(where: { $0.key == account.id }))
        XCTAssertFalse(accountingFacade.chartOfAccounts.accounts[account.id]?.tags[""]?.contains("Tag") ?? false)
        XCTAssertNoThrow(try accountingFacade.addTag("Tag", forAccount: account))
        XCTAssertTrue(accountingFacade.chartOfAccounts.accounts[account.id]?.tags[""]?.contains("Tag") ?? false)
    }
    
    func testRemoveTag() {
        let account = Account(name: "Account Name", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertNoThrow(try accountingFacade.addAccount(account))
        XCTAssertTrue(accountingFacade.chartOfAccounts.accounts.contains(where: { $0.key == account.id }))
        XCTAssertFalse(accountingFacade.chartOfAccounts.accounts[account.id]?.tags[""]?.contains("Tag") ?? false)
        XCTAssertNoThrow(try accountingFacade.addTag("Tag", forAccount: account))
        XCTAssertTrue(accountingFacade.chartOfAccounts.accounts[account.id]?.tags[""]?.contains("Tag") ?? false)
        XCTAssertNoThrow(try accountingFacade.removeTag("Tag", forAccount: account))
        XCTAssertFalse(accountingFacade.chartOfAccounts.accounts[account.id]?.tags[""]?.contains("Tag") ?? false)
    }
    
    func testRemoveAllTagsForAccount() {
        let account = Account(name: "Account Name", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertNoThrow(try accountingFacade.addAccount(account))
        XCTAssertTrue(accountingFacade.chartOfAccounts.accounts.contains(where: { $0.key == account.id }))
        XCTAssertFalse(accountingFacade.chartOfAccounts.accounts[account.id]?.tags[""]?.contains("Tag") ?? false)
        XCTAssertNoThrow(try accountingFacade.addTag("Tag", forAccount: account))
        XCTAssertTrue(accountingFacade.chartOfAccounts.accounts[account.id]?.tags[""]?.contains("Tag") ?? false)
        XCTAssertNoThrow(try accountingFacade.addTag("Tag 2", forAccount: account))
        XCTAssertTrue(accountingFacade.chartOfAccounts.accounts[account.id]?.tags[""]?.contains("Tag 2") ?? false)
        XCTAssertNoThrow(try accountingFacade.removeAllTagsForAccount(account))
        XCTAssertTrue(accountingFacade.chartOfAccounts.accounts[account.id]?.tags[""]?.isEmpty ?? true)
    }
    
    func testRemoveAllTagsForAccountWithCategory() {
        let account = Account(name: "Account Name", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertNoThrow(try accountingFacade.addAccount(account))
        XCTAssertTrue(accountingFacade.chartOfAccounts.accounts.contains(where: { $0.key == account.id }))
        XCTAssertFalse(accountingFacade.chartOfAccounts.accounts[account.id]?.tags[""]?.contains("Tag") ?? false)
        XCTAssertNoThrow(try accountingFacade.addTag("Tag", forAccount: account, withCategory: ""))
        XCTAssertTrue(accountingFacade.chartOfAccounts.accounts[account.id]?.tags[""]?.contains("Tag") ?? false)
        XCTAssertNoThrow(try accountingFacade.addTag("Tag 2", forAccount: account, withCategory: "Category"))
        XCTAssertTrue(accountingFacade.chartOfAccounts.accounts[account.id]?.tags["Category"]?.contains("Tag 2") ?? false)
        XCTAssertNoThrow(try accountingFacade.removeAllTagsForAccount(account))
        XCTAssertTrue(accountingFacade.chartOfAccounts.accounts[account.id]?.tags[""]?.isEmpty ?? true)
        XCTAssertTrue(accountingFacade.chartOfAccounts.accounts[account.id]?.tags["Category"]?.isEmpty ?? true)
    }
        
    static var allTests = [
        ("testAddAccount", testAddAccount),
        ("testUpdateAccount", testUpdateAccount),
        ("testDeleteAccount", testDeleteAccount),
        ("testHideAccount", testHideAccount),
        ("testAddTag", testAddTag),
        ("testRemoveTag", testRemoveTag),
        ("testRemoveAllTagsForAccount", testRemoveAllTagsForAccount),
        ("testRemoveAllTagsForAccountWithCategory", testRemoveAllTagsForAccountWithCategory),
    ]
}

