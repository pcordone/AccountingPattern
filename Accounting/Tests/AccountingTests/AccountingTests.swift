import XCTest
@testable import Accounting

final class AccountingTests: XCTestCase {
    func testBasic() {
        var openingBalEvent = AccountingEvent(accountNumber: AccountNumber("12345"), otherParty: OtherParty(name: "Other Party"), isProcessed: false, whenNoticed: nil, whenOccurred: Date(), eventType: AccountingEventTypes.openingbalance)
        let account = Account(name: "Checking")
        let openingBalEntry = Entry(date: Date(), entryType: EntryType.openingbalance, amount: 1000, account: account)
        openingBalEvent.addResultingEntry(openingBalEntry)
        XCTAssertEqual(1, openingBalEvent.resultingEntries.count)
        XCTAssertTrue(openingBalEvent.resultingEntries.contains(openingBalEntry))
        
        var purchaseEvent = AccountingEvent(accountNumber: AccountNumber("12345"), otherParty: OtherParty(name: "Other Party"), isProcessed: false, whenNoticed: nil, whenOccurred: Date(), eventType: AccountingEventTypes.purchase)
        let purchaseEntry = Entry(date: Date(), entryType: .purchase, amount: 12.52, account: account)
        purchaseEvent.addResultingEntry(purchaseEntry)
        XCTAssertEqual(1, purchaseEvent.resultingEntries.count)
        XCTAssertTrue(purchaseEvent.resultingEntries.contains(purchaseEntry))
        let notAddedEntry = Entry(date: Date(), entryType: .withdraw, amount: 100.0, account: account)
        XCTAssertFalse(purchaseEvent.resultingEntries.contains(notAddedEntry))
    }

    static var allTests = [
        ("testBasic", testBasic),
    ]
}
