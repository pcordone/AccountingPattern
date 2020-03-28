//
//  MoneyBag.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/27/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

/**
 A container for storing .
 - Note: Starts on page 23.
 - Note: TODO I need to finish this.
 */
public struct MoneyBag {
    private(set) var balances: Dictionary<CurrencyType, Money>
    
    public init(balances: Dictionary<CurrencyType, Money>) {
        self.balances = balances
    }
    
    public mutating func addAmount(_ amount: Money) {
        if let balance = self.balances[amount.currency] {
            self.balances[amount.currency] = balance + amount
        } else {
            self.balances[amount.currency] = amount
        }
    }
    
    public mutating func clear() {
        self.balances.removeAll()
    }
}
