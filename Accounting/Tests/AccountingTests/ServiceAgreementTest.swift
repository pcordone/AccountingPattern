//
//  AgreementTest.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/21/20.
//

import XCTest
@testable import Accounting
@testable import DataStructures

final class ServiceAgreementTests: XCTestCase {
    func testAddPostingRuleRule() {
        let now = Date()
        var agreement = ServiceAgreement()
        let postingRule = AccountPostingRule()
        agreement.addPostingRule(postingRule, forEventType: AccountingEvent.POSTING_EVENT_TYPE, andDate: now)
        XCTAssertEqual(1, agreement.postingRules.count)
        let serviceRule = agreement.postingRules.first?.value.values.first?.value
        XCTAssertNotNil(serviceRule)
        XCTAssertTrue(serviceRule is AccountPostingRule)
    }
    
    static var allTests = [
        ("testAddPostingRuleRule", testAddPostingRuleRule),
    ]
}

