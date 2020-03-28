//
//  RuleFindError.swift
//  
//
//  Created by Peter Wiley-Cordone on 3/25/20.
//

import Foundation

public enum RuleFindError: Error {
    case cantFindPostingRuleForEventType
    case cantFindPostingRuleForDate
    case postingRuleAlreadyExistsForEventType
}
