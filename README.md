# Code Timer
![macOS](https://img.shields.io/badge/os-macOS-green.svg?style=flat)
![Linux](https://img.shields.io/badge/os-linux-green.svg?style=flat)
![Apache 2](https://img.shields.io/badge/license-Apache2-blue.svg?style=flat)

This package provides a few help functions attached to the Timer class for timing code blocks (closures).
Timing of code bocks can be helpful in a couple of ways.  The purposes I has in mind while writing these were:
1. Time blocks for output to user to give updates on long and complex tasks.
2. Time blocks of code that use 3rd party libraries and/or web services to monitor if theres been changes in performance that is causing my applications to slow down.

## Usage
```swift
 let duration: TimeInterval = Timer.time { /* Code Block Here */ }
 let duration: TimeInterval = Timer.time( { /* Code Block Here */ } )
 let duration: TimeInterval = Timer.time( block: /* AutoClosure Code Block Here */ )
 
 let r: (TimeInterval, Results) = Timer.timeWithResults { /* Code Block Here, returning Results */ }
 let r: (TimeInterval, Results) = Timer.timeWithResults( { /* Code Block Here, returning Results */ } )
 let r: (TimeInterval, Results) = Timer.timeWithResults( block: /* AutoClosure Code Block Here, returning Results */ )
 
 
 func callback(_ timer: Timer, _ duration: TimeInterval) {
    // Retrieve duration here
 }
 let timer = Timer.scheduledTimedTimer(withTimeInterval: time, repeats: false, callback: callback) { /* Code Block Here */ }
 let timer = Timer.scheduledTimedTimer(withTimeInterval: time, repeats: false, callback: callback, { /* Code Block Here */ })
 let timer = Timer.scheduledTimedTimer(withTimeInterval: time, repeats: false, callback: callback, block: { /* AutoClosure Code Block Here */ })
 
 // Results = returning type from block code
 func callbackWithResults(_ timer: Timer, _ duration: TimeInterval, _ results: Results) {
    // Retrieve duration here
    // Retrieve results
 }
 let timer = Timer.scheduledTimedTimerWithResults(withTimeInterval: time, repeats: false, callback: callbackWithResults) { /* Code Block Here, returning Results */ }
 let timer = Timer.scheduledTimedTimerWithResults(withTimeInterval: time, repeats: false, callback: callbackWithResults, { /* Code Block Here, returning Results */ })
 let timer = Timer.scheduledTimedTimerWithResults(withTimeInterval: time, repeats: false, callback: callbackWithResults, block: { /* AutoClosure Code Block Here, returning Results */ })
```
## Author

* **Tyler Anger** - *Initial work* - [TheAngryDarling](https://github.com/TheAngryDarling)

## License

This project is licensed under Apache License v2.0 - see the [LICENSE.md](LICENSE.md) file for details
