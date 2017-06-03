//
//  ActivityTracker.swift
//  Premier
//
//  Created by Ilter Cengiz on 19/02/2017.
//  Copyright © 2017 Ilter Cengiz. All rights reserved.
//

import Foundation

/**
 Structure to keep track of any number of activities.
 */
public struct ActivityTracker: Equatable {
    
    /// Number of live activities.
    public fileprivate(set) var activityCount: UInt = 0
    
    /// True if `isActive` state changed from true to false or vice versa.
    public fileprivate(set) var activeStateChanged = false
    
    /// True if there is one or more activity.
    public var isActive: Bool {
        return activityCount > 0
    }
    
    /**
     Increments activity count by one.
     */
    public mutating func addActivity() {
        activeStateChanged = (activityCount == 0)
        activityCount += 1
    }
    
    /**
     Decrements activity count by one. Does nothing if activity count is 0.
     */
    public mutating func removeActivity() {
        guard activityCount > 0 else {
            // Similar to index out of bounds exception:
            fatalError("[ActivityTracker] There is no activity to remove.")
        }
        activityCount -= 1
        activeStateChanged = (activityCount == 0)
    }
}

public func ==(lhs: ActivityTracker, rhs: ActivityTracker) -> Bool {
    return lhs.activeStateChanged == rhs.activeStateChanged && lhs.activityCount == rhs.activityCount
}
