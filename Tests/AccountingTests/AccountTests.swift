import XCTest
@testable import Accounting

final class AccountTests: XCTestCase {
    func testAddEntry() {
        let now = Date()
        var account = Account(name: "Account Name", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertEqual(0, account.entries.count)
        let eventId = UUID()
        let id = UUID()
        // test addEntry with an entry object as a parameter
        let openingBalEntry = Entry(eventId: eventId, date: now, entryType: .debit, amount: 1000, otherParty: OtherParty(name: "Other Party"), note: "Note text.", id: id)
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

    func testBalanceBetween() {
        if #available(OSX 10.12, iOS 10.0, *) {
            let now = Date()
            var account = Account(name: "Account Name", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
            XCTAssertEqual(Money(0, .USD), account.balanceBetween(DateInterval(start: now.addingTimeInterval(-1), end: now.addingTimeInterval(1))))
            let entryNow = Entry(eventId: UUID(), date: now, entryType: .debit, amount: 1000, otherParty: OtherParty(name: "Other Party"), note: "Note text.")
            XCTAssertNoThrow(try account.addEntry(entryNow))
            let entryPast = Entry(eventId: UUID(), date: now.addingTimeInterval(-1), entryType: .debit, amount: 500, otherParty: OtherParty(name: "Other Party"), note: "Note text.")
            XCTAssertNoThrow(try account.addEntry(entryPast))
            let entryFuture = Entry(eventId: UUID(), date: now.addingTimeInterval(1), entryType: .debit, amount: 2000, otherParty: OtherParty(name: "Other Party"), note: "Note text.")
            XCTAssertNoThrow(try account.addEntry(entryFuture))
            XCTAssertEqual(Money(3500, .USD), account.balanceBetween(DateInterval(start: now.addingTimeInterval(-1), end: now.addingTimeInterval(1))))
            XCTAssertEqual(Money(1500, .USD), account.balanceBetween(DateInterval(start: now.addingTimeInterval(-1), end: now)))
            XCTAssertEqual(Money(3000, .USD), account.balanceBetween(DateInterval(start: now, end: now.addingTimeInterval(1))))
        }
    }
    
    func testBalanceAsOf() {
        let now = Date()
        var account = Account(name: "Account Name", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertEqual(Money(0, .USD), account.balanceAsOf(now))
        let openingBalEntry = Entry(eventId: UUID(), date: now, entryType: .debit, amount: 1000, otherParty: OtherParty(name: "Other Party"), note: "Note text.")
        XCTAssertNoThrow(try account.addEntry(openingBalEntry))
        XCTAssertEqual(Money(1000, .USD), account.balanceAsOf(now))
        XCTAssertEqual(Money(1000, .USD), account.balanceAsOf(now.addingTimeInterval(1)))
        XCTAssertEqual(Money(0, .USD), account.balanceAsOf(now.addingTimeInterval(-1)))
    }
    
    func testBalance() {
        let now = Date()
        var account = Account(name: "Account Name", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertEqual(Money(0, .USD), account.balance)
        let openingBalEntry = Entry(eventId: UUID(), date: now, entryType: .debit, amount: 1000, otherParty: OtherParty(name: "Other Party"), note: "Note text.")
        XCTAssertNoThrow(try account.addEntry(openingBalEntry))
        XCTAssertEqual(Money(1000, .USD), account.balance)
    }
    
    private func makeCreditAndDebitEntriesForAccount(_ account: Account, withNow: Date) -> Account {
        var account = account
        let debitEntryNow = Entry(eventId: UUID(), date: withNow, entryType: .debit, amount: 1000, otherParty: OtherParty(name: "Other Party"), note: "Note text.")
        XCTAssertNoThrow(try account.addEntry(debitEntryNow))
        let debitEntryPast = Entry(eventId: UUID(), date: withNow.addingTimeInterval(-1), entryType: .debit, amount: 500, otherParty: OtherParty(name: "Other Party"), note: "Note text.")
        XCTAssertNoThrow(try account.addEntry(debitEntryPast))
        let debitEntryFuture = Entry(eventId: UUID(), date: withNow.addingTimeInterval(1), entryType: .debit, amount: 2000, otherParty: OtherParty(name: "Other Party"), note: "Note text.")
        XCTAssertNoThrow(try account.addEntry(debitEntryFuture))
        let creditEntryNow = Entry(eventId: UUID(), date: withNow, entryType: .credit, amount: 1000, otherParty: OtherParty(name: "Other Party"), note: "Note text.")
        XCTAssertNoThrow(try account.addEntry(creditEntryNow))
        let creditEntryPast = Entry(eventId: UUID(), date: withNow.addingTimeInterval(-1), entryType: .credit, amount: 400, otherParty: OtherParty(name: "Other Party"), note: "Note text.")
        XCTAssertNoThrow(try account.addEntry(creditEntryPast))
        let creditEntryFuture = Entry(eventId: UUID(), date: withNow.addingTimeInterval(1), entryType: .credit, amount: 2200, otherParty: OtherParty(name: "Other Party"), note: "Note text.")
        XCTAssertNoThrow(try account.addEntry(creditEntryFuture))
        return account
    }
    
    func testDebitsBetween() {
        if #available(OSX 10.12, iOS 10.0, *) {
            let now = Date()
            var account = Account(name: "Account Name", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
            XCTAssertEqual(Money(0, .USD), account.debitsBetween(DateInterval(start: now.addingTimeInterval(-1), end: now.addingTimeInterval(1))))
            account = makeCreditAndDebitEntriesForAccount(account, withNow: now)
            XCTAssertEqual(Money(3500, .USD), account.debitsBetween(DateInterval(start: now.addingTimeInterval(-1), end: now.addingTimeInterval(1))))
            XCTAssertEqual(Money(1500, .USD), account.debitsBetween(DateInterval(start: now.addingTimeInterval(-1), end: now)))
            XCTAssertEqual(Money(3000, .USD), account.debitsBetween(DateInterval(start: now, end: now.addingTimeInterval(1))))
        }
    }
    
    func testCreditsBetween() {
        if #available(OSX 10.12, iOS 10.0, *) {
        let now = Date()
        var account = Account(name: "Account Name", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertEqual(Money(0, .USD), account.debitsBetween(DateInterval(start: now.addingTimeInterval(-1), end: now.addingTimeInterval(1))))
        account = makeCreditAndDebitEntriesForAccount(account, withNow: now)
            XCTAssertEqual(Money(3600, .USD), account.creditsBetween(DateInterval(start: now.addingTimeInterval(-1), end: now.addingTimeInterval(1))))
        XCTAssertEqual(Money(1400, .USD), account.creditsBetween(DateInterval(start: now.addingTimeInterval(-1), end: now)))
        XCTAssertEqual(Money(3200, .USD), account.creditsBetween(DateInterval(start: now, end: now.addingTimeInterval(1))))
            
        }
    }
    
    func testHashable() {
        let account = Account(name: "Account One", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertEqual(account.id.hashValue, account.hashValue)
    }
    
    func testEquatable() {
        let account = Account(name: "Account One", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        let account2 = Account(name: "Account Two", type: .liability, number: AccountNumber("654321"), currency: CurrencyType.AED, id: account.id)
        XCTAssertEqual(account, account2)
        let account3 = Account(name: account.name, type: account.type, number: account.number, currency: account.currency, id: UUID())
        XCTAssertNotEqual(account, account3)
    }
    
    func testTagsDefaultCategory() {
        var account = Account(name: "Account One", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertTrue(account.tags.isEmpty)
        XCTAssertFalse(account.hasTag("Tag"))
        account.addTag("Tag")
        XCTAssertTrue(account.hasTag("Tag"))
        XCTAssertNoThrow(try account.removeTag("Tag"))
        XCTAssertFalse(account.hasTag("Tag"))
        account.addTag("Tag")
        account.addTag("Tag Tag")
        XCTAssertEqual(2, account.tags[""]?.count)
        account.removeAllTags()
        XCTAssertTrue(account.tags.isEmpty)
    }
    
    func testTagsWithCategory() {
        var account = Account(name: "Account One", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertTrue(account.tags.isEmpty)
        XCTAssertFalse(account.hasTag("Tag", forCategory: "Category 1"))
        account.addTag("Tag", forCategory: "Category 1")
        XCTAssertEqual(1, account.tags["Category 1"]?.count)
        XCTAssertTrue(account.hasTag("Tag", forCategory: "Category 1"))
        XCTAssertNil(account.tags["Category 2"])
        XCTAssertFalse(account.hasTag("Tag", forCategory: "Category 2"))
        account.addTag("Tag", forCategory: "Category 2")
        XCTAssertEqual(1, account.tags["Category 2"]?.count)
        XCTAssertTrue(account.hasTag("Tag", forCategory: "Category 2"))
        XCTAssertNoThrow(try account.removeTag("Tag", forCategory: "Category 1"))
        XCTAssertFalse(account.hasTag("Tag", forCategory: "Category 1"))
        XCTAssertTrue(account.hasTag("Tag", forCategory: "Category 2"))
        account.addTag("Tag", forCategory: "Category 1")
        XCTAssertEqual(1, account.tags["Category 1"]?.count)
        XCTAssertNoThrow(try account.removeAllTagsForCategory("Category 1"))
        XCTAssertTrue(account.tags["Category 1"]?.isEmpty ?? false)
        account.addTag("Tag", forCategory: "Category 1")
        XCTAssertFalse(account.tags["Category 1"]?.isEmpty ?? true)
        XCTAssertFalse(account.tags["Category 2"]?.isEmpty ?? true)
        account.removeAllTags()
        XCTAssertTrue(account.tags.isEmpty)
    }
    
    public func testAccountEntriesSortedByDate() {
        let now = Date()
        let eventId = UUID()
        var account = Account(name: "Account Name", type: .asset, number: AccountNumber("123456"), currency: CurrencyType.USD)
        XCTAssertNoThrow(try account.addEntry(eventId: eventId, type: .credit, amount: 3000, date: now.addingTimeInterval(-1), otherParty: OtherParty(name: "Other Party Second Credit")))
        XCTAssertNoThrow(try account.addEntry(eventId: eventId, type: .debit, amount: 1000, date: now, otherParty: OtherParty(name: "Other Party First Debit")))
        XCTAssertNoThrow(try account.addEntry(eventId: eventId, type: .credit, amount: 2000, date: now.addingTimeInterval(1), otherParty: OtherParty(name: "Other Party First Credit")))
        let entriesAscending = account.entriesSortedByDate(.ascending)
        XCTAssertEqual(3000, entriesAscending[0].amount)
        XCTAssertEqual(1000, entriesAscending[1].amount)
        XCTAssertEqual(2000, entriesAscending[2].amount)
        let entriesDescending = account.entriesSortedByDate(.descending)
        XCTAssertEqual(2000, entriesDescending[0].amount)
        XCTAssertEqual(1000, entriesDescending[1].amount)
        XCTAssertEqual(3000, entriesDescending[2].amount)
    }
    
    static var allTests = [
        ("testAddEntry", testAddEntry),
        ("testBalanceBetween", testBalanceBetween),
        ("testBalance", testBalance),
        ("testDebitsBetween", testDebitsBetween),
        ("testCreditsBetween", testCreditsBetween),
        ("testBalanceAsOf", testBalanceAsOf),
        ("testHashable", testHashable),
        ("testEquatable", testEquatable),
        ("testTagsDefaultCategory", testTagsDefaultCategory),
        ("testTagsWithCategory", testTagsWithCategory),
    ]
}
