//
//  Timer+CodeTimer.swift
//  CodeTimer
//
//  Created by Tyler Anger on 2018-09-16.
//

import Foundation

public extension Timer {
    
    /// Monitors the amount of time it takes to execute the given block of code.
    /// Returns the time the block of code took to complete as well as the results from the block
    ///
    /// - Parameter block: The block of code to time while executing
    /// - Returns: returns a turple containing the time the block of code took and the results from the block of code
    static func timeWithResults<Results>( _ block: () throws -> Results) rethrows -> (TimeInterval, Results) {
        let startTime: Date = Date()
        let results = try block()
        let duration = startTime.timeIntervalSinceNow.magnitude
        return (duration, results)
    }
    
    /// Monitors the amount of time it takes to execute the given block of code.
    /// Returns the time the block of code took to complete as well as the results from the block
    ///
    /// - Parameter block: The block of code to time while executing
    /// - Returns: returns a turple containing the time the block of code took and the results from the block of code
    static func timeWithResults<Results>( block: @autoclosure () throws -> Results) rethrows -> (TimeInterval, Results) {
        let startTime: Date = Date()
        let results = try block()
        let duration = startTime.timeIntervalSinceNow.magnitude
        return (duration, results)
    }
    
    /// Monitors the amount of time it takes to execute the given block of code.
    /// Returns the time the block of code took to complete
    ///
    /// - Parameter block: The block of code to time while executing
    /// - Returns: returns the time the block of code took to execute
    static func time( _ block: () throws -> Void ) rethrows -> TimeInterval {
        let startTime: Date = Date()
        try block()
        return startTime.timeIntervalSinceNow.magnitude
    }
    
    /// Monitors the amount of time it takes to execute the given block of code.
    /// Returns the time the block of code took to complete
    ///
    /// - Parameter block: The block of code to time while executing
    /// - Returns: returns the time the block of code took to execute
    static func time( block: @autoclosure () throws -> Void ) rethrows -> TimeInterval {
        let startTime: Date = Date()
        try block()
        return startTime.timeIntervalSinceNow.magnitude
    }
    
    
    
    /// Schedules a time when to execute a code block.  Then monitors the time it takes for the code block to run
    /// Once completed the callback function will be called with the timer, time it took and results
    ///
    /// - Parameters:
    ///   - interval: The number of seconds between firings of the timer. If seconds is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead
    ///   - repeats: repeats  If YES, the timer will repeatedly reschedule itself until invalidated. If NO, the timer will be invalidated after it fires.
    ///   - callback: The callback which is executed after each time the block is executed.  The call back provides the timer being used, the duration of the block execution, as well as any resulst from the block executation
    ///   - block: The execution body of the timer; the timer itself is passed as the parameter to this block when executed to aid in avoiding cyclical references
    /// - Returns: returns the Timer object created for this scheduled task
    @available(OSX 10.12, *)
    @discardableResult
    static func scheduledTimedTimerWithResults<Results>(withTimeInterval interval: TimeInterval,
                                                       repeats: Bool = false,
                                                       callback: @escaping (Timer, TimeInterval, Results) -> Void,
                                                       _ block: @escaping () -> Results ) -> Timer {
        return scheduledTimer(withTimeInterval: interval, repeats: repeats) { timer in
            let startTime: Date = Date()
            let results = block()
            let d = startTime.timeIntervalSinceNow.magnitude
            
            callback(timer, d, results)
        }
        
    }
    
    /// Schedules a time when to execute a code block.  Then monitors the time it takes for the code block to run
    /// Once completed the callback function will be called with the timer, time it took and results
    ///
    /// - Parameters:
    ///   - interval: The number of seconds between firings of the timer. If seconds is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead
    ///   - repeats: repeats  If YES, the timer will repeatedly reschedule itself until invalidated. If NO, the timer will be invalidated after it fires.
    ///   - callback: The callback which is executed after each time the block is executed.  The call back provides the timer being used, the duration of the block execution, as well as any resulst from the block executation
    ///   - block: The execution body of the timer; the timer itself is passed as the parameter to this block when executed to aid in avoiding cyclical references
    /// - Returns: returns the Timer object created for this scheduled task
    @available(OSX 10.12, *)
    @discardableResult
    static func scheduledTimedTimerWithResults<Results>(withTimeInterval interval: TimeInterval,
                                                       repeats: Bool = false,
                                                       callback: @escaping (Timer, TimeInterval, Results) -> Void,
                                                       block: @autoclosure @escaping () -> Results ) -> Timer {
        
        return scheduledTimedTimerWithResults(withTimeInterval: interval, repeats: repeats, callback: callback, block)
    }
    
    /// Schedules a time when to execute a code block.  Then monitors the time it takes for the code block to run
    /// Once completed the callback function will be called with the timer, time it took and results
    ///
    /// - Parameters:
    ///   - interval: The number of seconds between firings of the timer. If seconds is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead
    ///   - repeats: repeats  If YES, the timer will repeatedly reschedule itself until invalidated. If NO, the timer will be invalidated after it fires.
    ///   - callback: The callback which is executed after each time the block is executed.  The call back provides the timer being used, the duration of the block execution, as well as any resulst from the block executation
    ///   - block: The execution body of the timer; the timer itself is passed as the parameter to this block when executed to aid in avoiding cyclical references
    /// - Returns: returns the Timer object created for this scheduled task
    @available(OSX 10.12, *)
    @discardableResult
    static func scheduledTimedTimerWithResults<Results>(withTimeInterval interval: Int,
                                                       repeats: Bool = false,
                                                       callback: @escaping (Timer, TimeInterval, Results) -> Void,
                                                       _ block: @escaping () -> Results ) -> Timer {
        return scheduledTimedTimerWithResults(withTimeInterval: TimeInterval(interval), repeats: repeats, callback: callback, block)
    }
    
    /// Schedules a time when to execute a code block.  Then monitors the time it takes for the code block to run
    /// Once completed the callback function will be called with the timer, time it took and results
    ///
    /// - Parameters:
    ///   - interval: The number of seconds between firings of the timer. If seconds is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead
    ///   - repeats: repeats  If YES, the timer will repeatedly reschedule itself until invalidated. If NO, the timer will be invalidated after it fires.
    ///   - callback: The callback which is executed after each time the block is executed.  The call back provides the timer being used, the duration of the block execution, as well as any resulst from the block executation
    ///   - block: The execution body of the timer; the timer itself is passed as the parameter to this block when executed to aid in avoiding cyclical references
    /// - Returns: returns the Timer object created for this scheduled task
    @available(OSX 10.12, *)
    @discardableResult
    static func scheduledTimedTimerWithResults<Results>(withTimeInterval interval: Int,
                                                       repeats: Bool = false,
                                                       callback: @escaping (Timer, TimeInterval, Results) -> Void,
                                                       block: @autoclosure @escaping () -> Results ) -> Timer {
        return scheduledTimedTimerWithResults(withTimeInterval: interval, repeats: repeats, callback: callback, block)
    }
    
    /// Schedules a time when to execute a code block.  Then monitors the time it takes for the code block to run
    /// Once completed the callback function will be called with the timer and the time it took
    ///
    /// - Parameters:
    ///   - interval: The number of seconds between firings of the timer. If seconds is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead
    ///   - repeats: repeats  If YES, the timer will repeatedly reschedule itself until invalidated. If NO, the timer will be invalidated after it fires.
    ///   - callback: The callback which is executed after each time the block is executed.  The call back provides the timer being used, the duration of the block execution, as well as any resulst from the block executation
    ///   - block: The execution body of the timer; the timer itself is passed as the parameter to this block when executed to aid in avoiding cyclical references
    /// - Returns: returns the Timer object created for this scheduled task
    @available(OSX 10.12, *)
    @discardableResult
    static func scheduledTimedTimer(withTimeInterval interval: TimeInterval,
                                   repeats: Bool = false,
                                   callback: @escaping (Timer, TimeInterval) -> Void,
                                   _ block: @escaping () -> Void ) -> Timer {
        
        return scheduledTimer(withTimeInterval: interval, repeats: repeats) { timer in
            let d: TimeInterval = Timer.time(block)
            
            callback(timer, d)
        }
    }
    
    /// Schedules a time when to execute a code block.  Then monitors the time it takes for the code block to run
    /// Once completed the callback function will be called with the timer and the time it took
    ///
    /// - Parameters:
    ///   - interval: The number of seconds between firings of the timer. If seconds is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead
    ///   - repeats: repeats  If YES, the timer will repeatedly reschedule itself until invalidated. If NO, the timer will be invalidated after it fires.
    ///   - callback: The callback which is executed after each time the block is executed.  The call back provides the timer being used, the duration of the block execution, as well as any resulst from the block executation
    ///   - block: The execution body of the timer; the timer itself is passed as the parameter to this block when executed to aid in avoiding cyclical references
    /// - Returns: returns the Timer object created for this scheduled task
    @available(OSX 10.12, *)
    @discardableResult
    static func scheduledTimedTimer(withTimeInterval interval: TimeInterval,
                                   repeats: Bool = false,
                                   callback: @escaping (Timer, TimeInterval) -> Void,
                                   block: @autoclosure @escaping () -> Void ) -> Timer {
        
        return scheduledTimedTimer(withTimeInterval: interval, repeats: repeats, callback: callback, block)
    }
    
    /// Schedules a time when to execute a code block.  Then monitors the time it takes for the code block to run
    /// Once completed the callback function will be called with the timer and the time it took
    ///
    /// - Parameters:
    ///   - interval: The number of seconds between firings of the timer. If seconds is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead
    ///   - repeats: repeats  If YES, the timer will repeatedly reschedule itself until invalidated. If NO, the timer will be invalidated after it fires.
    ///   - callback: The callback which is executed after each time the block is executed.  The call back provides the timer being used, the duration of the block execution, as well as any resulst from the block executation
    ///   - block: The execution body of the timer; the timer itself is passed as the parameter to this block when executed to aid in avoiding cyclical references
    /// - Returns: returns the Timer object created for this scheduled task
    @available(OSX 10.12, *)
    @discardableResult
    static func scheduledTimedTimer(withTimeInterval interval: Int,
                                   repeats: Bool = false,
                                   callback: @escaping (Timer, TimeInterval) -> Void,
                                   _ block: @escaping () -> Void ) -> Timer {
        return scheduledTimedTimer(withTimeInterval: TimeInterval(interval), repeats: repeats, callback: callback, block)
    }
    
    /// Schedules a time when to execute a code block.  Then monitors the time it takes for the code block to run
    /// Once completed the callback function will be called with the timer and the time it took
    ///
    /// - Parameters:
    ///   - interval: The number of seconds between firings of the timer. If seconds is less than or equal to 0.0, this method chooses the nonnegative value of 0.1 milliseconds instead
    ///   - repeats: repeats  If YES, the timer will repeatedly reschedule itself until invalidated. If NO, the timer will be invalidated after it fires.
    ///   - callback: The callback which is executed after each time the block is executed.  The call back provides the timer being used, the duration of the block execution, as well as any resulst from the block executation
    ///   - block: The execution body of the timer; the timer itself is passed as the parameter to this block when executed to aid in avoiding cyclical references
    /// - Returns: returns the Timer object created for this scheduled task
    @available(OSX 10.12, *)
    @discardableResult
    static func scheduledTimedTimer(withTimeInterval interval: Int,
                                   repeats: Bool = false,
                                   callback: @escaping (Timer, TimeInterval) -> Void,
                                   block: @autoclosure @escaping () -> Void ) -> Timer {
        return scheduledTimedTimer(withTimeInterval: interval, repeats: repeats, callback: callback, block)
    }
}
