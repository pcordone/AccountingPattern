//
//  PostingRulesTests.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/8/20.
//

import Foundation
import XCTest
@testable import Accounting
    
final class PostingRulesTests: XCTestCase {

    func testAccountPostingRule() {
        let postingRule = AccountPostingRule()
        let now = Date()
        let account = Account(name: "Account Name", number: AccountNumber("12345"), currency: .USD)
        XCTAssertEqual(0, account.entries.count)
        let agreement = ServiceAgreement()
        let otherParty = OtherParty(name: "Other Party")
        // test an debit
        let event = AccountingEvent(name: "Test postentry debit", eventType: .postentry, whenOccurred: now, whenNoticed: nil, isProcessed: false, otherParty: otherParty, agreement: agreement, amount: Money(100), account: account, entryType: .debit)
        XCTAssertNoThrow(try postingRule.processEvent(event))
        XCTAssertEqual(1, account.entries.count)
        XCTAssertNotNil(account.entries.first)
        let entry = account.entries.first!
        XCTAssertEqual(now, entry.date)
        XCTAssertEqual(Money(100), entry.amount)
        XCTAssertEqual(.debit, entry.entryType)
        XCTAssertEqual(otherParty.id, entry.otherParty.id)
        XCTAssertEqual(event.id, entry.eventId)
        XCTAssertEqual(event.entryType, .debit)
    }
    
    static var allTests = [
        ("testAccountPostingRule", testAccountPostingRule),
    ]
}
