//
//  Event.swift
//  Accounting
//
//  Created by Peter Cordone on 5/2/19.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//
// Implementation of Martin Fowlers's accounting pattern https://www.martinfowler.com/eaaDev/AccountingNarrative.html.

import Foundation

/**
 Captures the memory of something interesting which affects the domain.  This class is abstract and should not be instantiated.
 - Note: Starts on page 11.  See page 13 for discussion about how to handle mutability.  I kept it simple in this implementaiton and allowed the isProcessed and whenNoticed properties to be mutable since those are the ones that will change after initial creation.
 */
public protocol Event: Hashable, Identifiable {
    var eventType: EventType { get }
    var whenOccurred: Date { get }
    var whenNoticed: Date? { get set }
    var isProcessed: Bool { get set }
}
