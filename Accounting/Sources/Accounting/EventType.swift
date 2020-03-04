//
//  EventType.swift
//  sophrosyne
//
//  Created by Peter Wiley-Cordone on 3/3/20.
//  Copyright © 2020 Peter Cordone. All rights reserved.
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
