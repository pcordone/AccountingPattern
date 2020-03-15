//
//  File.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/4/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

public struct ServiceAgreement {
    private var postingRules = Dictionary<EventType, TemporalCollection>()
    
    public mutating func addPostingRule(_ rule: PostingRule, forEventType eventType: EventType, andDate date: Date) {
        var temporalCollection = postingRules[eventType]
        if temporalCollection == nil {
            temporalCollection = TemporalCollection(allowDuplicates: false)
            postingRules[eventType] = temporalCollection
        }
        temporalCollection![date] = rule
    }

    public func getPostingRuleForEventType(_ eventType: EventType, date: Date) -> PostingRule? {
        guard let temporalCollection = postingRules[eventType] else {
            fatalError("Couldn't find TemporalCollection for event type \(eventType)")
        }
        return temporalCollection[date, .previous]
    }
}
