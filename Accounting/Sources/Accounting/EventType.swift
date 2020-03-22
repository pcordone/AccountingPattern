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
public class EventType: NamedObject, Identifiable {
    public var name: String
    public var id: UUID

    public init(name: String) {
        self.name = name
        self.id = UUID()
    }
}

extension EventType: Hashable {
    public var hashValue: Int {
        var hasher = Hasher()
        self.hash(into: &hasher)
        return hasher.finalize()
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id.hashValue)
    }
    
    public static func == (lhs: EventType, rhs: EventType) -> Bool {
        return lhs.id == rhs.id
    }
}
