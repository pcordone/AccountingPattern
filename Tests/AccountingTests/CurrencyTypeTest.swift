//
//  CurrencyTypeTest.swift
//  sophrosyneTests
//
//  Created by Peter Cordone on 4/29/19.
//  Copyright © 2019 Peter Cordone. All rights reserved.
//

import Foundation

import XCTest
@testable import Accounting

class CurrencyTypeTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCurrencyFromLocale() {
        XCTAssertEqual(CurrencyType.currencyFromLocale(Locale(identifier: "en_US")), CurrencyType.USD)
    }
    
    func testCurrencyForDefaultLocale() {
        XCTAssertEqual(CurrencyType.currencyForDefaultLocale(), CurrencyType.USD)
    }
    
    func testCurrencyFormatted() throws {
        XCTAssertEqual(CurrencyType.formatAmount(100.25, withLocale: Locale.current), "$100.25")
        XCTAssertEqual(CurrencyType.formatWithCurrentLocaleAmount(Decimal(0.01)), "$0.01")
        XCTAssertEqual(CurrencyType.formatWithCurrentLocaleAmount(Decimal(100)), "$100.00")
    }
    
    static var allTests = [
        ("testCurrencyFromLocale", testCurrencyFromLocale),
        ("testCurrencyForDefaultLocale", testCurrencyForDefaultLocale),
        ("testCurrencyFormatted", testCurrencyFormatted),
    ]
}
