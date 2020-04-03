//
//  UsingAccountingPackateTest.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/19/20.
//

import XCTest
@testable import Accounting

final class AccountingPackateTest: XCTestCase {
    var postingRule: AccountPostingRule!
    var now: Date!
    
    override func setUp() {
        postingRule = AccountPostingRule()
        now = Date()
    }
    
    func testPackageServiceAgreementPostEvent() throws {
        var agreement = ServiceAgreement()
        let otherParty = OtherParty(name: "Other Party Opening Balance")
        let event: AccountingEvent = AccountingEvent(name: "Opening Balance Event", whenOccurred: now, whenNoticed: nil, isProcessed: false, otherParty: otherParty, amount: Money(100.0), account: Account(name: "First Account", type: .asset, number: AccountNumber("12345"), currency: .USD), entryType: .debit)
        agreement.addPostingRule(postingRule, forEventType: AccountingEvent.POSTING_EVENT_TYPE, andDate: now)
        // store the generated id of the event so we can make sure they match after the call to processEvent
        let eventIdBeforeProcessCall = event.id
        XCTAssertTrue(event.account.entries.isEmpty)
        let processedEvent = try agreement.processEvent(event)
        // make sure the id's match before and after the process call so that I can rely on id
        XCTAssertEqual(eventIdBeforeProcessCall, processedEvent.id)
        XCTAssertEqual(1, processedEvent.account.entries.count)
        XCTAssertNotNil(processedEvent.account.entries.first)
        guard let entry = processedEvent.account.entries.first else {
            return XCTFail("Expected a single entry but got none!")
        }
        XCTAssertEqual(now, entry.date)
        XCTAssertEqual(Money(100), entry.amount)
        XCTAssertEqual(.debit, entry.type)
        XCTAssertEqual(otherParty.id, entry.otherParty.id)
    }
    
    func testPackageRulesRepositoryPostEvent() throws {
        let rulesRepository = RulesRepository()
        let otherParty = OtherParty(name: "Other Party Opening Balance")
        let event: AccountingEvent = AccountingEvent(name: "Opening Balance Event", whenOccurred: now, whenNoticed: nil, isProcessed: false, otherParty: otherParty, amount: Money(100.0), account: Account(name: "First Account", type: .asset, number: AccountNumber("12345"), currency: .USD), entryType: .debit)
        XCTAssertNoThrow(try rulesRepository.addPostingRule(postingRule, forEventType: AccountingEvent.POSTING_EVENT_TYPE))
        // store the generated id of the event so we can make sure they match after the call to processEvent
        let eventIdBeforeProcessCall = event.id
        XCTAssertTrue(event.account.entries.isEmpty)
        let processedEvent = try rulesRepository.processEvent(event)
        // make sure the id's match before and after the process call so that I can rely on id
        XCTAssertEqual(eventIdBeforeProcessCall, processedEvent.id)
        XCTAssertEqual(1, processedEvent.account.entries.count)
        XCTAssertNotNil(processedEvent.account.entries.first)
        guard let entry = processedEvent.account.entries.first else {
            return XCTFail("Expected a single entry but got none!")
        }
        XCTAssertEqual(now, entry.date)
        XCTAssertEqual(Money(100), entry.amount)
        XCTAssertEqual(.debit, entry.type)
        XCTAssertEqual(otherParty.id, entry.otherParty.id)
    }
    
    static var allTests = [
        ("testPackageServiceAgreementPostEvent", testPackageServiceAgreementPostEvent),
        ("testPackageRulesRepositoryPostEvent", testPackageRulesRepositoryPostEvent),
    ]
}
