//
//  PostingRule.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/4/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

public protocol PostingRule {
    func processEvent(_ event: AccountingEvent) throws
}
