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

    func testPostingRuleToOneAccount() {
        let postingRule = PostingRuleToOneAccount(entryType: .openingbalance)
        let now = Date()
        let otherParty = OtherParty(name: "Other Party Name")
        let event = MoneyEvent(otherParty: otherParty, isProcessed: false, whenNoticed: nil, whenOccurred: now, eventType: EventType(name: "Event Name"), amount: 1.0)
        let account = Account(name: "Account Name", number: AccountNumber("12345"), currency: .USD)
        var COA = ChartOfAccounts()
        XCTAssertNoThrow(try COA.addAccount(account))
        XCTAssertNoThrow(try postingRule.processEvent(event, withChartOfAccounts: COA))
        XCTAssertEqual(1, account.entries.count)
        let entry = account.entries.first
        XCTAssertEqual(1.0, entry?.amount.amount)
        XCTAssertEqual(now, entry?.date)
        XCTAssertEqual(.openingbalance, entry?.entryType)
        XCTAssertEqual(otherParty, entry?.otherParty)
    }
    
    static var allTests = [
        ("testTemporalCollection", testPostingRuleToOneAccount),
    ]
}
