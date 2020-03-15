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
public protocol EventType: NamedObject {
    var id: UUID { get }
}

extension EventType {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.id.hashValue)
    }
}
