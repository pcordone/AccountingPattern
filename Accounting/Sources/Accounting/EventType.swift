//
//  EventType.swift
//  sophrosyne
//
//  Created by Peter Cordone on 5/3/19.
//  Copyright © 2019 Peter Cordone. All rights reserved.
//

import Foundation

/**
 The event type.
- Note: Starts on page 11.
*/
public class EventType: NamedObject, Equatable, Hashable {
    public let id = UUID()
    public var name: String
    
    public static func == (lhs: EventType, rhs: EventType) -> Bool {
        return lhs.id == rhs.id
    }
    
    public init(name: String) {
        self.name = name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id.hashValue)
    }
}
