//
//  PostingRulesTests.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/8/20.
//

import Foundation
import XCTest
@testable import Accounting

// TODO delete me
//struct TemporalPostingRule: Comparable {
//    let postingRule: PostingRule
//    let date: Date
//
//    init(postingRule: PostingRule, date: Date) {
//        self.postingRule = postingRule
//        self.date = date
//    }
//
//    static func < (lhs: TemporalPostingRule, rhs: TemporalPostingRule) -> Bool {
//        return lhs.date < rhs.date
//    }
//
//    static func == (lhs: TemporalPostingRule, rhs: TemporalPostingRule) -> Bool {
//        return lhs.date == rhs.date
//    }
//}
    
final class PostingRulesTests: XCTestCase {

    func testPostingRuleToOneAccount() {
        let postingRule = PostingRuleToOneAccount(entryType: .openingbalance)
        let now = Date()
        let otherParty = OtherParty(name: "Other Party Name")
        let event = MoneyEvent(otherParty: otherParty, isProcessed: false, whenNoticed: nil, whenOccurred: now, eventType: EventType(name: "Event Name"), amount: 1.0)
        let account = Account(name: "Account Name", number: AccountNumber("12345"), currency: .USD)
        XCTAssertNoThrow(try postingRule.processEvent(event, withAccounts: [account]))
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
