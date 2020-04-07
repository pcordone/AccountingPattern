//
//  File.swift
//  
//
//  Created by Peter Wiley-Cordone on 4/5/20.
//

import XCTest
@testable import Accounting
@testable import DataStructures

final class BalanceTest: XCTestCase {
    var debitOne: DebitsCredits!
    var creditOne: DebitsCredits!
    var debitOneEntry: Entry!
    var creditOneEntry: Entry!

    override func setUp() {
        debitOne = DebitsCredits(debit: 1, credit: 0)
        creditOne = DebitsCredits(debit: 0, credit: 1)
        let eventId = UUID()
        debitOneEntry = Entry(eventId: eventId, date: Date(), entryType: .debit, amount: 1, otherParty: OtherParty(name: "Other Party Name"))
        creditOneEntry = Entry(eventId: eventId, date: Date(), entryType: .credit, amount: 1, otherParty: OtherParty(name: "Other Party Name"))
    }
    
    func testAddingTwoBalances() {
        var result = DebitsCredits.zero + debitOne
        XCTAssertEqual(1, result.debit)
        XCTAssertEqual(0, result.credit)
        result = DebitsCredits.zero + creditOne
        XCTAssertEqual(0, result.debit)
        XCTAssertEqual(1, result.credit)
        result = debitOne + creditOne
        XCTAssertEqual(1, result.debit)
        XCTAssertEqual(1, result.credit)
    }
    
    func testSubtractingTwoBalances() {
        var result = DebitsCredits.zero - debitOne
        XCTAssertEqual(-1, result.debit)
        XCTAssertEqual(0, result.credit)
        result = DebitsCredits.zero - creditOne
        XCTAssertEqual(0, result.debit)
        XCTAssertEqual(-1, result.credit)
        result = debitOne - creditOne
        XCTAssertEqual(1, result.debit)
        XCTAssertEqual(-1, result.credit)
        result = creditOne - debitOne
        XCTAssertEqual(-1, result.debit)
        XCTAssertEqual(1, result.credit)
    }
    
    func testPlusEqualsBalance() {
        var result = DebitsCredits.zero
        result += debitOne
        XCTAssertEqual(1, result.debit)
        XCTAssertEqual(0, result.credit)
        result = DebitsCredits.zero
        result += creditOne
        XCTAssertEqual(0, result.debit)
        XCTAssertEqual(1, result.credit)
    }
    
    func testPlusEqualsBalanceAndEntry() {
        var result = DebitsCredits.zero
        result += debitOneEntry
        XCTAssertEqual(1, result.debit)
        XCTAssertEqual(0, result.credit)
        result = DebitsCredits.zero
        result += creditOneEntry
        XCTAssertEqual(0, result.debit)
        XCTAssertEqual(1, result.credit)
    }
    
    func testMinusEqualsBalance() {
        var result = DebitsCredits.zero
        result -= debitOne
        XCTAssertEqual(-1, result.debit)
        XCTAssertEqual(0, result.credit)
        result = DebitsCredits.zero
        result -= creditOne
        XCTAssertEqual(0, result.debit)
        XCTAssertEqual(-1, result.credit)
    }
    
    func testMinusEqualsBalanceAndEntry() {
        var result = DebitsCredits.zero
        result -= debitOneEntry
        XCTAssertEqual(-1, result.debit)
        XCTAssertEqual(0, result.credit)
        result = DebitsCredits.zero
        result -= creditOneEntry
        XCTAssertEqual(0, result.debit)
        XCTAssertEqual(-1, result.credit)
    }
    
    func testAddingABalanceAndEntry() {
        var result = DebitsCredits.zero + debitOneEntry
        XCTAssertEqual(1, result.debit)
        XCTAssertEqual(0, result.credit)
        result = DebitsCredits.zero + creditOneEntry
        XCTAssertEqual(0, result.debit)
        XCTAssertEqual(1, result.credit)
    }
    
    func testSubractingABalanceAndEntry() {
        var result = DebitsCredits.zero - debitOneEntry
        XCTAssertEqual(-1, result.debit)
        XCTAssertEqual(0, result.credit)
        result = DebitsCredits.zero - creditOneEntry
        XCTAssertEqual(0, result.debit)
        XCTAssertEqual(-1, result.credit)
    }
    
    func testAddingZerosTogether() {
        let result = DebitsCredits.zero + DebitsCredits.zero
        XCTAssertEqual(0, result.debit)
        XCTAssertEqual(0, result.credit)
    }
    
    static var allTests = [
        ("testAddingTwoBalances", testAddingTwoBalances),
        ("testPlusEqualsBalance", testPlusEqualsBalance),
        ("testPlusEqualsBalanceAndEntry", testPlusEqualsBalanceAndEntry),
        ("testMinusEqualsBalance", testMinusEqualsBalance),
        ("testMinusEqualsBalanceAndEntry", testMinusEqualsBalanceAndEntry),
        ("testSubtractingTwoBalances", testSubtractingTwoBalances),
        ("testAddingABalanceAndEntry", testAddingABalanceAndEntry),
        ("testSubractingABalanceAndEntry", testSubractingABalanceAndEntry),
        ("testAddingZerosTogether", testAddingZerosTogether),
    ]
}
