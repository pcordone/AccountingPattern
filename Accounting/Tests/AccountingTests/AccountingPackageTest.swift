//
//  UsingAccountingPackateTest.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/19/20.
//

import XCTest
@testable import Accounting

final class AccountingPackateTest: XCTestCase {
    func testPackagePostEvent() {
        let now = Date()
        let agreement = ServiceAgreement()
        let postingRule = AccountPostingRule()
        let account = Account(name: "First Account", number: AccountNumber("12345"), currency: .USD)
        agreement.addPostingRule(postingRule, forEventType: AccountingEventType.postentry, andDate: now)
        let event = AccountingEvent(name: "Opening Balance Event", eventType: AccountingEventType.postentry, whenOccurred: now, whenNoticed: nil, isProcessed: false, otherParty: OtherParty(name: "Other Party Opening Balance"), agreement: agreement, amount: Money(1000.0), account: account, entryType: .debit)
        XCTAssertTrue(account.entries.isEmpty)
        XCTAssertNoThrow(try event.process())
        XCTAssertEqual(1, account.entries.count)
        let entry = Entry(id: account.entries.first!.id, eventId: event.id, date: event.whenOccurred, entryType: event.entryType, amount: event.amount, otherParty: event.otherParty)
        XCTAssertEqual(entry, account.entries.first)
//        XCTAssertEqual(1, account.entries.count)
//        XCTAssertTrue(account.entries.contains(openingBalEntry))
//        let purchaseEntry = Entry(eventId: event.id, date: Date(), entryType: .purchase, amount: 12.52, otherParty: OtherParty(name: "Other Party Name"))
//        XCTAssertNoThrow(try account.addEntry(purchaseEntry))
//        XCTAssertEqual(2, account.entries.count)
//        XCTAssertTrue(account.entries.contains(purchaseEntry))
//        let notAddedEntry = Entry(eventId: event.id, date: Date(), entryType: .withdraw, amount: 100.0, otherParty: OtherParty(name: "Entry Other Party"))
//        XCTAssertFalse(account.entries.contains(notAddedEntry))
        }
    }
