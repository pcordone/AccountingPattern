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

final class MoneyTests: XCTestCase {
    func testMonetaryCalculations() throws {
        let prices: [Money] = [2.19, 5.39, 20.99, 2.99, 1.99, 1.99, 0.99]
        let subtotal = prices.reduce(0.00, +)
        let tax = 0.08 * subtotal
        let total = subtotal + tax

        XCTAssertEqual(subtotal.amount, Decimal(string: "36.53", locale: nil))
        XCTAssertEqual(tax.amount, Decimal(string: "2.92", locale: nil))
        XCTAssertEqual(total.amount, Decimal(string: "39.45", locale: nil))
    }
    
    func testInitMoneyFromFloat() {
        let money = Money(1.0, CurrencyType.USD)
        XCTAssertEqual(money.amount, 1.0)
    }
    
    func testInitMoneyFromMoney() {
        let money = Money(1.0, CurrencyType.USD)
        let result = Money(money)
        XCTAssertEqual(money.amount, result.amount)
        XCTAssertEqual(money.currency, result.currency)
    }
    
    func testInitMoneyFromStringWithDefaultLocale() {
        let money = Money("1.0")
        XCTAssertEqual(money.amount, 1.0)
    }
    
    
    func testSumMoney() {
        let lhs = Money(1)
        let rhs = Money(1)
        let two = Money(2)
        XCTAssertEqual(lhs + rhs, two)
    }
    
    static var allTests = [
        ("testMonetaryCalculations", testMonetaryCalculations),
        ("testInitMoneyFromFloat", testInitMoneyFromFloat),
        ("testInitMoneyFromStringWithDefaultLocale", testInitMoneyFromStringWithDefaultLocale),
        ("testSumMoney", testSumMoney),
    ]
}
