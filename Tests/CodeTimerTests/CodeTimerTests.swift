import XCTest
@testable import CodeTimer


final class CodeTimerTests: XCTestCase {
    let sleepTime: TimeInterval = 10
    
    func testBasicTimedCodeBlock() {
        
        let d: TimeInterval = Timer.time { Thread.sleep(forTimeInterval: sleepTime) }
        XCTAssertTrue(d > (sleepTime - 1) && d < (sleepTime + 1), "Durations did not match.  Expected \(sleepTime) ± 1 but returned \(d)")
    }
    
    func testBasicTimedCodeBlockUsingAutoClosure() {
        
        let d: TimeInterval = Timer.time( block: Thread.sleep(forTimeInterval: sleepTime) )
        XCTAssertTrue(d > (sleepTime - 1) && d < (sleepTime + 1), "Durations did not match.  Expected \(sleepTime) ± 1 but returned \(d)")
    }
    
    func testResultsTimedCodeBlock() {
        
        let r: (TimeInterval, Int) = Timer.timeWithResults {
            Thread.sleep(forTimeInterval: sleepTime)
            return 1
        }
        XCTAssertTrue(r.0 > (sleepTime - 1) && r.0 < (sleepTime + 1), "Durations did not match.  Expected \(sleepTime) ± 1 but returned \(r.0)")
    }
    
    func testResultsTimedCodeBlockUsingAutoClosure() {
        func doSomething() -> Int {
            Thread.sleep(forTimeInterval: sleepTime)
            return 1
        }
        
        let r = Timer.timeWithResults( block: doSomething() )
        XCTAssertTrue(r.0 > (sleepTime - 1) && r.0 < (sleepTime + 1), "Durations did not match.  Expected \(sleepTime) ± 1 but returned \(r.0)")
    }
    
    @available(OSX 10.12, *)
    func testBasicScheduledTimedCodeBlock() {
        var d: TimeInterval = 0
        //let expectation = XCTestExpectation(description: "Callback executed")
        let expectation = self.expectation(description: "Callback executed")
        func callback(_ timer: Timer, _ duration: TimeInterval) {
            d = duration
            expectation.fulfill()
        }
        Timer.scheduledTimedTimer(withTimeInterval: sleepTime, repeats: false, callback: callback) {
            Thread.sleep(forTimeInterval: self.sleepTime)
        }
        self.waitForExpectations(timeout: (sleepTime * 6), handler: nil)
        //wait(for: [expectation], timeout: (sleepTime * 6))
        XCTAssertTrue(d > (sleepTime - 1) && d < (sleepTime + 1), "Durations did not match.  Expected \(sleepTime) ± 1 but returned \(d)")
    }
    
    @available(OSX 10.12, *)
    func testBasicScheduledTimedCodeBlockUsingAutoClosure() {
        var d: TimeInterval = 0
        //let expectation = XCTestExpectation(description: "Callback executed")
        let expectation = self.expectation(description: "Callback executed")
        func callback(_ timer: Timer, _ duration: TimeInterval) {
            d = duration
            expectation.fulfill()
        }
        Timer.scheduledTimedTimer(withTimeInterval: sleepTime, repeats: false, callback: callback, block: Thread.sleep(forTimeInterval: self.sleepTime))
        self.waitForExpectations(timeout: (sleepTime * 6), handler: nil)
        //wait(for: [expectation], timeout: (sleepTime * 6))
        XCTAssertTrue(d > (sleepTime - 1) && d < (sleepTime + 1), "Durations did not match.  Expected \(sleepTime) ± 1 but returned \(d)")
    }
    
    @available(OSX 10.12, *)
    func testResultsScheduledTimedCodeBlock() {
        var d: TimeInterval = 0
        //let expectation = XCTestExpectation(description: "Callback executed")
        let expectation = self.expectation(description: "Callback executed")
        func callback(_ timer: Timer, _ duration: TimeInterval, _ results: Int) {
            d = duration
            expectation.fulfill()
        }
        Timer.scheduledTimedTimerWithResults(withTimeInterval: sleepTime, repeats: false, callback: callback) {
            Thread.sleep(forTimeInterval: self.sleepTime)
            return 1
        }
        self.waitForExpectations(timeout: (sleepTime * 6), handler: nil)
        //wait(for: [expectation], timeout: (sleepTime * 6))
        XCTAssertTrue(d > (sleepTime - 1) && d < (sleepTime + 1), "Durations did not match.  Expected \(sleepTime) ± 1 but returned \(d)")
    }
    
    @available(OSX 10.12, *)
    func testResultsScheduledTimedCodeBlockUsingAutoClosure() {
        var d: TimeInterval = 0
        //let expectation = XCTestExpectation(description: "Callback executed")
        let expectation = self.expectation(description: "Callback executed")
        func callback(_ timer: Timer, _ duration: TimeInterval, _ results: Int) {
            d = duration
            expectation.fulfill()
        }
        func doSomething() -> Int {
            Thread.sleep(forTimeInterval: sleepTime)
            return 1
        }
        Timer.scheduledTimedTimerWithResults(withTimeInterval: sleepTime, repeats: false, callback: callback, block: doSomething())
        self.waitForExpectations(timeout: (sleepTime * 6), handler: nil)
        //wait(for: [expectation]/*, timeout: (sleepTime * 6)*/)
        XCTAssertTrue(d > (sleepTime - 1) && d < (sleepTime + 1), "Durations did not match.  Expected \(sleepTime) ± 1 but returned \(d)")
    }

    /*static var allTests = [
        ("testBasicTimedCodeBlock", testBasicTimedCodeBlock),
        ("testBasicScheduledTimedCodeBlock", testBasicScheduledTimedCodeBlock),
    ]*/
    static var allTests: [(String, (CodeTimerTests)->()->())] {
        var rtn = [
                    ("testBasicTimedCodeBlock", testBasicTimedCodeBlock),
                    ("testBasicTimedCodeBlockUsingAutoClosure", testBasicTimedCodeBlockUsingAutoClosure),
                    ("testResultsTimedCodeBlock", testResultsTimedCodeBlock),
                    ("testResultsTimedCodeBlockUsingAutoClosure", testResultsTimedCodeBlockUsingAutoClosure)
                   ]
        if #available(OSX 10.12, *) {
            rtn.append(("testBasicScheduledTimedCodeBlock", testBasicScheduledTimedCodeBlock))
            rtn.append(("testBasicScheduledTimedCodeBlockUsingAutoClosure", testBasicScheduledTimedCodeBlockUsingAutoClosure))
            rtn.append(("testResultsScheduledTimedCodeBlock", testResultsScheduledTimedCodeBlock))
            rtn.append(("testResultsScheduledTimedCodeBlockUsingAutoClosure", testResultsScheduledTimedCodeBlockUsingAutoClosure))
        }
        return rtn
    }
}
