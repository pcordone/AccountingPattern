import XCTest
@testable import Accounting

final class AccountTests: XCTestCase {
    func testAddEntry() {
        let now = Date()
        let account = Account(name: "Account Name", number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertEqual(0, account.entries.count)
        let eventId = UUID()
        let id = UUID()
        // test addEntry with an entry object as a parameter
        let openingBalEntry = Entry(id: id, eventId: eventId, date: now, entryType: .debit, amount: 1000, otherParty: OtherParty(name: "Other Party"))
        XCTAssertNoThrow(try account.addEntry(openingBalEntry))
        XCTAssertEqual(1, account.entries.count)
        XCTAssertTrue(account.entries.contains(openingBalEntry))
        // test addEntry with individual fields
        let deposityEntry = Entry(eventId: eventId, date: now, entryType: .debit, amount: 2000, otherParty: OtherParty(name: "Entry object other party"))
        XCTAssertNoThrow(try account.addEntry(eventId: eventId, type: .debit, amount: 2000, date: now, otherParty: OtherParty(name: "Entry object other party")))
        XCTAssertEqual(2, account.entries.count)
        // equality is on id value and we didn't pass one in, so below should be false
        XCTAssertFalse(account.entries.contains(deposityEntry))
        XCTAssertNoThrow(try account.addEntry(deposityEntry))
        XCTAssertTrue(account.entries.contains(deposityEntry))
    }
    
    static var allTests = [
        ("testAddEntry", testAddEntry),
    ]
}
