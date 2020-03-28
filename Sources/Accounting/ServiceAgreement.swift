//
//  File.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/4/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
//

import Foundation

public struct ServiceAgreement {
    var postingRules = Dictionary<EventType, TemporalCollection>()
    
    public mutating func addPostingRule(_ rule: PostingRule, forEventType eventType: EventType, andDate date: Date) {
        if postingRules[eventType] == nil {
            postingRules[eventType] = TemporalCollection(allowDuplicates: false)
        }
        postingRules[eventType]![date] = rule
    }

    public func findPostingRuleForEventType(_ eventType: EventType, date: Date) throws -> PostingRule {
        guard let temporalCollection = postingRules[eventType] else {
            throw RuleFindError.cantFindPostingRuleForEventType
        }
        guard let rule = temporalCollection[date, .previous] else {
            throw RuleFindError.cantFindPostingRuleForDate
        }
        return rule
    }
    
    public mutating func processEvent(_ event: inout AccountingEvent) throws {
        let postingRule = try findPostingRuleForEventType(event.type, date: event.whenOccurred)
        try postingRule.processEvent(&event)
    }
}
