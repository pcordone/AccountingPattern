//
//  EntryType.swift
//
//  Created by Peter Wiley-Cordone on 3/3/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation
import SwiftUI

/**
The type of accounting entry.  Proposed as part of Posting Rule pattern where the EntryType determines the rule to run which creates the entry.
- Note: Starts on page 23.
*/
public enum EntryType: String, Equatable, CaseIterable, Hashable {
    case openingbalance = "Opening Balance"
    case deposit = "Deposit"
    case withdraw = "Withdraw"
    case purchase = "Purchase"
    case refund = "Refund"
    case transfer = "Transfer"
}
