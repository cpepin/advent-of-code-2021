//: [Previous](@previous)

import Foundation

class Day1 {
    let measurements: [Int?]
    
    private static func numOfIncreases(values: [Int?]) -> Int {
        var increases = 0
        var previousValue: Int? = nil
        for value in values {
            if let currValue = value, let prevValue = previousValue, currValue > prevValue {
                increases += 1
            }
            previousValue = value
        }
        
        return increases
    }

    init() {
        do {
            if let inputUrl = Bundle.main.url(forResource: "pt1-input", withExtension: "txt") {
                let inputString = try String(contentsOf: inputUrl)
                measurements = inputString.split{ $0.isNewline }.map{ Int($0) }
            } else {
                preconditionFailure("Cannot find input file")
            }
        } catch {
            preconditionFailure("Error loading contents of input file: \(error)")
        }
    }
    
    func pt1() -> Int {
        return Day1.numOfIncreases(values: measurements)
    }
    
    func pt2() -> Int {
        let initialResult = measurements[...2].reduce(0) { res, curr in
            var newResult = 0
            if let val = curr {
                newResult += val
            }
            return newResult
        }
        
        var subIndex = 0
        let measurementWindows = measurements[3...].reduce([initialResult]) { partialResult, current in
            var window = 0
            
            if let currValue = current {
                window += currValue
            }
            
            if let lastItem = partialResult.last {
                window += lastItem
            }
            
            if let subValue = measurements[subIndex] {
                window -= subValue
            }

            let newResult = partialResult + [window];
            subIndex += 1
            
            return newResult
        }
        
        return Day1.numOfIncreases(values: measurementWindows)
    }
}

//: [Next](@next)

let day1 = Day1()

print("Part 1 answer: ", day1.pt1())
print("Part 2 answer: ", day1.pt2())
