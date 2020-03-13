import XCTest
@testable import Accounting

final class AccountingTests: XCTestCase {
    func testAccountEntries() {
        var account = Account(name: "Account Name", number: AccountNumber("123456"), currency: CurrencyType.USD)
        let event = AccountingEvent(otherParty: OtherParty(name: "Other Party name"), isProcessed: false, whenNoticed: nil, whenOccurred: Date(), eventType: MoneyEventTypes.openingbalance)
        let openingBalEntry = Entry(eventId: event.id, date: Date(), entryType: .openingbalance, amount: 1000, otherParty: OtherParty(name: "Other Party"))
        XCTAssertNoThrow(try account.addEntry(openingBalEntry))
        XCTAssertEqual(1, account.entries.count)
        XCTAssertTrue(account.entries.contains(openingBalEntry))
        let purchaseEntry = Entry(eventId: event.id, date: Date(), entryType: .purchase, amount: 12.52, otherParty: OtherParty(name: "Other Party Name"))
        XCTAssertNoThrow(try account.addEntry(purchaseEntry))
        XCTAssertEqual(2, account.entries.count)
        XCTAssertTrue(account.entries.contains(purchaseEntry))
        let notAddedEntry = Entry(eventId: event.id, date: Date(), entryType: .withdraw, amount: 100.0, otherParty: OtherParty(name: "Entry Other Party"))
        XCTAssertFalse(account.entries.contains(notAddedEntry))
    }
    
    static var allTests = [
        ("testAccountEntries", testAccountEntries),
    ]
}
