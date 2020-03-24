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
        var agreement = ServiceAgreement()
        let postingRule = AccountPostingRule()
        let account = Account(name: "First Account", number: AccountNumber("12345"), currency: .USD)
        agreement.addPostingRule(postingRule, forEventType: AccountingEvent.POSTING_EVENT_TYPE, andDate: now)
        var event: AccountingEvent = AccountingEvent(name: "Opening Balance Event", whenOccurred: now, whenNoticed: nil, isProcessed: false, otherParty: OtherParty(name: "Other Party Opening Balance"), agreement: agreement, amount: Money(1000.0), account: account, entryType: .debit)
        XCTAssertTrue(account.entries.isEmpty)
        XCTAssertNoThrow(try agreement.processEvent(&event))
        XCTAssertEqual(1, account.entries.count)
        //let entry = Entry(eventId: event.id, date: event.whenOccurred, entryType: event.entryType, amount: event.amount, otherParty: event.otherParty, id: account.entries.first!.id)
        //XCTAssertEqual(entry, account.entries.first)
        }
    }
