//
//  TemporalCollectionTest.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/21/20.
//

import XCTest
@testable import Accounting
@testable import DataStructures

final class TemporalCollectionTest: XCTestCase {

    func testTemporalCollection() {
        var temporalCollection = TemporalCollection(allowDuplicates: false)
        let postingRule = AccountPostingRule()
        let now = Date()
        temporalCollection[now] = postingRule
        XCTAssertEqual(1, temporalCollection.count)
        XCTAssertEqual(1, temporalCollection.keys.count)
        XCTAssertEqual(1, temporalCollection.values.count)
        XCTAssertNotNil(temporalCollection[now])
        XCTAssertTrue(temporalCollection[now] is AccountPostingRule)
        XCTAssertTrue(postingRule === (temporalCollection[now] as! AccountPostingRule))
    }
    
    static var allTests = [
        ("testTemporalCollection", testTemporalCollection),
    ]
}
