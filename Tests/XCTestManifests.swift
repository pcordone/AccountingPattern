import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AccountingTests.allTests),
        testCase(DatastructuresTests.allTests),
    ]
}
#endif
