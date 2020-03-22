//
//  Event.swift
//  Accounting
//
//  Created by Peter Wiley-Cordone on 3/3/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//
// Implementation of Martin Fowlers's accounting pattern https://www.martinfowler.com/eaaDev/AccountingNarrative.html.
//

import Foundation

/**
 Captures the memory of something interesting which affects the domain.  This class is abstract and should not be instantiated.
 - Note: Starts on page 11.  See page 13 for discussion about how to handle mutability.  I kept it simple in this implementaiton and allowed the isProcessed and whenNoticed properties to be mutable since those are the ones that will change after initial creation.
 - Note: We will start with a protocol since all event instances may not be monetary accounting events.  For instance, we may start mixing time accounting with monitary, or we could create meditative reminder events and post to a mental health account, or maybe create social events (i.e. supportive social media content) and reack up a virtual social media score.
 */
public protocol Event: NamedObject {
    func process() throws
    func findRule() throws -> PostingRule
}
