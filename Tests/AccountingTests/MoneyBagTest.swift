//
//  MoneyBagTest.swift
//  sophrosyneTests
//
//  Created by Peter Cordone on 5/7/19.
//  Copyright © 2019 Peter Cordone. All rights reserved.
//

import Foundation

import XCTest
@testable import Accounting

class MoneyBagTest: XCTestCase {
    var moneybag: MoneyBag?
    
    override func setUp() {
        self.moneybag = MoneyBag(balances: Dictionary<CurrencyType, Money>())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddAmount() {
        self.moneybag?.addAmount(Money(1.0, CurrencyType.USD))
        XCTAssertEqual(self.moneybag?.balances.count, 1)
        XCTAssertEqual(self.moneybag?.balances[CurrencyType.USD], Money(1.0, CurrencyType.USD))
        self.moneybag?.addAmount(Money(1.0, CurrencyType.USD))
        XCTAssertEqual(self.moneybag?.balances.count, 1)
        XCTAssertEqual(self.moneybag?.balances[CurrencyType.USD], Money(2.0, CurrencyType.USD))
        self.moneybag?.addAmount(Money(1.0, CurrencyType.XTS))
        XCTAssertEqual(self.moneybag?.balances.count, 2)
        XCTAssertEqual(self.moneybag?.balances[CurrencyType.USD], Money(2.0, CurrencyType.USD))
        XCTAssertEqual(self.moneybag?.balances[CurrencyType.XTS], Money(1.0, CurrencyType.XTS))
        self.moneybag?.addAmount(Money(-1.0, CurrencyType.USD))
        XCTAssertEqual(self.moneybag?.balances.count, 2)
        XCTAssertEqual(self.moneybag?.balances[CurrencyType.USD], Money(1.0, CurrencyType.USD))
        XCTAssertEqual(self.moneybag?.balances[CurrencyType.XTS], Money(1.0, CurrencyType.XTS))
        
    }

    func testClear() {
        self.moneybag?.addAmount(Money(1.0, CurrencyType.USD))
        XCTAssertEqual(self.moneybag?.balances.count, 1)
        XCTAssertEqual(self.moneybag?.balances[CurrencyType.USD], Money(1.0, CurrencyType.USD))
        self.moneybag?.clear()
        XCTAssertEqual(self.moneybag?.balances.count, 0)
    }
    
    static var allTests = [
        ("testAddAmount", testAddAmount),
        ("testClear", testClear),
    ]
}
