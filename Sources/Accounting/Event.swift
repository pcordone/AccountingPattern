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
 I kept Events as storage objects (as he does on page 11) and did not introduce the ability for events to process themselves as he does when introducing PostingRules.
 - Note: Starts on page 11, "Captures the memory of something interesting which affects the domain.  This class is abstract and should not be instantiated.".  See page 13 for discussion about how to handle mutability.  I kept it simple in this implementaiton and allowed the isProcessed and whenNoticed properties to be mutable since those are the ones that will change after initial creation.
 - Note: We will start with a protocol since all event instances may not be monetary accounting events.  For instance, we may start mixing time accounting with monitary, or maybe create social events (i.e. supporting social media content) and reack up a virtual social media score.
 */
public protocol Event: NamedObject {
    var whenOccurred: Date { get }
    var whenNoticed: Date? { get }
    var isProcessed: Bool { get set }
    var type: EventType { get }
}
