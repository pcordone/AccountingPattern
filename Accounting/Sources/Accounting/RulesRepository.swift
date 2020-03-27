//
//  RulesRepository.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/25/20.
//

import Foundation

public class RulesRepository {
    var postingRules = Dictionary<EventType, PostingRule>()
    
    public func addPostingRule(_ rule: PostingRule, forEventType eventType: EventType) throws {
        guard !postingRules.contains(where: { $0.key == eventType }) else {
            throw RuleFindError.postingRuleAlreadyExistsForEventType
        }
        postingRules[eventType] = rule
    }

    public func findPostingRuleForEventType(_ eventType: EventType) throws -> PostingRule {
        guard let rule = postingRules[eventType] else {
            throw RuleFindError.cantFindPostingRuleForEventType
        }
        return rule
    }
    
    public func processEvent(_ event: inout AccountingEvent) throws {
        let postingRule = try findPostingRuleForEventType(event.type)
        try postingRule.processEvent(&event)
    }
}
