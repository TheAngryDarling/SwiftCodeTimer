//
//  Timer+CodeTimer.swift
//  CodeTimer
//
//  Created by Tyler Anger on 2018-09-16.
//

import Foundation

public extension Timer {
    
    // Monitors the amount of time it takes to execute the given block of code.
    // Returns the time the block of code took to complete as well as the results from the block
    public static func timeWithResults<Results>( _ block: () throws -> Results) rethrows -> (TimeInterval, Results) {
        let startTime: Date = Date()
        let results = try block()
        let duration = startTime.timeIntervalSinceNow.magnitude
        return (duration, results)
    }
    
    // Monitors the amount of time it takes to execute the given block of code.
    // Returns the time the block of code took to complete as well as the results from the block
    public static func timeWithResults<Results>( block: @autoclosure () throws -> Results) rethrows -> (TimeInterval, Results) {
        let startTime: Date = Date()
        let results = try block()
        let duration = startTime.timeIntervalSinceNow.magnitude
        return (duration, results)
    }
    
    // Monitors the amount of time it takes to execute the given block of code.
    // Returns the time the block of code took to complete
    public static func time( _ block: () throws -> Void ) rethrows -> TimeInterval {
        let startTime: Date = Date()
        try block()
        return startTime.timeIntervalSinceNow.magnitude
    }
    
    // Monitors the amount of time it takes to execute the given block of code.
    // Returns the time the block of code took to complete
    public static func time( block: @autoclosure () throws -> Void ) rethrows -> TimeInterval {
        let startTime: Date = Date()
        try block()
        return startTime.timeIntervalSinceNow.magnitude
    }
    
    
    
    // Schedules a time when to execute a code block.  Then monitors the time it takes for the code block to run
    // Once completed the callback function will be called with the timer, time it took and results
    @available(OSX 10.12, *)
    @discardableResult
    public static func scheduledTimedTimerWithResults<Results>(withTimeInterval duration: TimeInterval,
                                                               repeats: Bool = false,
                                                               callback: @escaping (Timer, TimeInterval, Results) -> Void,
                                                               _ block: @escaping () -> Results ) -> Timer {
        return scheduledTimer(withTimeInterval: duration, repeats: repeats) { timer in
            let startTime: Date = Date()
            let results = block()
            let d = startTime.timeIntervalSinceNow.magnitude
            
            callback(timer, d, results)
        }
        
    }
    
    // Schedules a time when to execute a code block.  Then monitors the time it takes for the code block to run
    // Once completed the callback function will be called with the timer, time it took and results
    @available(OSX 10.12, *)
    @discardableResult
    public static func scheduledTimedTimerWithResults<Results>(withTimeInterval duration: TimeInterval,
                                                               repeats: Bool = false,
                                                               callback: @escaping (Timer, TimeInterval, Results) -> Void,
                                                               block: @autoclosure @escaping () -> Results ) -> Timer {
        
        return scheduledTimedTimerWithResults(withTimeInterval: duration, repeats: repeats, callback: callback, block)
    }
    
    // Schedules a time when to execute a code block.  Then monitors the time it takes for the code block to run
    // Once completed the callback function will be called with the timer, time it took and results
    @available(OSX 10.12, *)
    @discardableResult
    public static func scheduledTimedTimerWithResults<Results>(withTimeInterval duration: Int,
                                                               repeats: Bool = false,
                                                               callback: @escaping (Timer, TimeInterval, Results) -> Void,
                                                               _ block: @escaping () -> Results ) -> Timer {
        return scheduledTimedTimerWithResults(withTimeInterval: TimeInterval(duration), repeats: repeats, callback: callback, block)
    }
    
    // Schedules a time when to execute a code block.  Then monitors the time it takes for the code block to run
    // Once completed the callback function will be called with the timer, time it took and results
    @available(OSX 10.12, *)
    @discardableResult
    public static func scheduledTimedTimerWithResults<Results>(withTimeInterval duration: Int,
                                                               repeats: Bool = false,
                                                               callback: @escaping (Timer, TimeInterval, Results) -> Void,
                                                               block: @autoclosure @escaping () -> Results ) -> Timer {
        return scheduledTimedTimerWithResults(withTimeInterval: duration, repeats: repeats, callback: callback, block)
    }
    
    // Schedules a time when to execute a code block.  Then monitors the time it takes for the code block to run
    // Once completed the callback function will be called with the timer and the time it took
    @available(OSX 10.12, *)
    @discardableResult
    public static func scheduledTimedTimer(withTimeInterval duration: TimeInterval,
                                           repeats: Bool = false,
                                           callback: @escaping (Timer, TimeInterval) -> Void,
                                           _ block: @escaping () -> Void ) -> Timer {
        
        return scheduledTimer(withTimeInterval: duration, repeats: repeats) { timer in
            let d: TimeInterval = Timer.time(block)
            
            callback(timer, d)
        }
    }
    
    // Schedules a time when to execute a code block.  Then monitors the time it takes for the code block to run
    // Once completed the callback function will be called with the timer and the time it took
    @available(OSX 10.12, *)
    @discardableResult
    public static func scheduledTimedTimer(withTimeInterval duration: TimeInterval,
                                           repeats: Bool = false,
                                           callback: @escaping (Timer, TimeInterval) -> Void,
                                           block: @autoclosure @escaping () -> Void ) -> Timer {
        
        return scheduledTimedTimer(withTimeInterval: duration, repeats: repeats, callback: callback, block)
    }
    
    // Schedules a time when to execute a code block.  Then monitors the time it takes for the code block to run
    // Once completed the callback function will be called with the timer and the time it took
    @available(OSX 10.12, *)
    @discardableResult
    public static func scheduledTimedTimer(withTimeInterval duration: Int,
                                           repeats: Bool = false,
                                           callback: @escaping (Timer, TimeInterval) -> Void,
                                           _ block: @escaping () -> Void ) -> Timer {
        return scheduledTimedTimer(withTimeInterval: TimeInterval(duration), repeats: repeats, callback: callback, block)
    }
    
    // Schedules a time when to execute a code block.  Then monitors the time it takes for the code block to run
    // Once completed the callback function will be called with the timer and the time it took
    @available(OSX 10.12, *)
    @discardableResult
    public static func scheduledTimedTimer(withTimeInterval duration: Int,
                                           repeats: Bool = false,
                                           callback: @escaping (Timer, TimeInterval) -> Void,
                                           block: @autoclosure @escaping () -> Void ) -> Timer {
        return scheduledTimedTimer(withTimeInterval: duration, repeats: repeats, callback: callback, block)
    }
}
