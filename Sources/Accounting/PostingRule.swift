//
//  PostingRule.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/4/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

/**
 Our protocol for posting rules.
 - Note: TODO is to use type erasure to be able to pass Event protocol so that we can process any structs implementing Event.  For now, let's move on.
 */
public protocol PostingRule {
    func processEvent(_ event: AccountingEvent) throws -> AccountingEvent
}
