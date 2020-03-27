//
//  RulesRepositoryTests.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/25/20.
//

import Foundation
import XCTest
@testable import Accounting

final class RulesRepositoryTests: XCTestCase {
    var rulesRepository: RulesRepository!
    var postingRule: AccountPostingRule!

    override func setUp() {
        rulesRepository = RulesRepository()
        postingRule = AccountPostingRule()
    }
    
    func testAddPostingRuleRule() {
        XCTAssertEqual(0, rulesRepository.postingRules.count)
        XCTAssertNoThrow(try rulesRepository.addPostingRule(postingRule, forEventType: AccountingEvent.POSTING_EVENT_TYPE))
        XCTAssertEqual(1, rulesRepository.postingRules.count)
        let postingRuleFromRepository = rulesRepository.postingRules.first?.value
        XCTAssertNotNil(postingRuleFromRepository)
        XCTAssertTrue(postingRuleFromRepository is AccountPostingRule)
        XCTAssertEqual(postingRule, (postingRuleFromRepository as! AccountPostingRule))
        // check that we throw if adding a rule that is already in the repository
        XCTAssertThrowsError(try rulesRepository.addPostingRule(postingRule, forEventType: AccountingEvent.POSTING_EVENT_TYPE), "Tried to add a rule for an event type that was already in the repository.  An error should have been thrown.") {
            error in XCTAssertEqual(error as? RuleFindError, RuleFindError.postingRuleAlreadyExistsForEventType)
        }
    }
    
    func testFindPostingRuleForEventType() {
        XCTAssertEqual(0, rulesRepository.postingRules.count)
        XCTAssertNoThrow(try rulesRepository.addPostingRule(postingRule, forEventType: AccountingEvent.POSTING_EVENT_TYPE))
        XCTAssertTrue(rulesRepository.postingRules.keys.contains(AccountingEvent.POSTING_EVENT_TYPE))
        do {
            let postingRuleFromRepository = try rulesRepository.findPostingRuleForEventType(AccountingEvent.POSTING_EVENT_TYPE)
            XCTAssertNotNil(postingRuleFromRepository)
            XCTAssertTrue(postingRuleFromRepository is AccountPostingRule)
            XCTAssertEqual(postingRule, (postingRuleFromRepository as! AccountPostingRule))
        } catch {
            XCTFail("Unexpected error \(error) thrown.")
        }
    }
    
    func testFindPostingRuleForEventTypeNotFound() {
        XCTAssertEqual(0, rulesRepository.postingRules.count)
        XCTAssertThrowsError(try rulesRepository.findPostingRuleForEventType(AccountingEvent.POSTING_EVENT_TYPE))
    }
        
    static var allTests = [
        ("testAddPostingRuleRule", testAddPostingRuleRule),
        ("testFindPostingRuleForEventType", testFindPostingRuleForEventType),
        ("testFindPostingRuleForEventTypeNotFound", testFindPostingRuleForEventTypeNotFound),

    ]
}
