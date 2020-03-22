//
//  File.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/4/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

public class ServiceAgreement {
    var postingRules = Dictionary<EventType, TemporalCollection>()
    
    public func addPostingRule(_ rule: PostingRule, forEventType eventType: EventType, andDate date: Date) {
        if postingRules[eventType] == nil {
            postingRules[eventType] = TemporalCollection(allowDuplicates: false)
        }
        postingRules[eventType]![date] = rule
    }

    public func getPostingRuleForEventType(_ eventType: EventType, date: Date) -> PostingRule? {
        guard let temporalCollection = postingRules[eventType] else {
            fatalError("Couldn't find TemporalCollection for event type \(eventType)")
        }
        return temporalCollection[date, .previous]
    }
}
