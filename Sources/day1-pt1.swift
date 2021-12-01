import Foundation

class Day1 {
    static func pt1() -> Int {
        if let inputUrl = Bundle.main.url(forResource: "day1/pt1", withExtension: "text") {
            do {
                let urlString = try String(contentsOf: inputUrl)
                let inputString = try String(contentsOfFile: urlString)
                let measurements = inputString.split{ $0.isNewline }.map{ Int($0) }
                
                var measurementIncreases = 0
                var previousMeasurement: Int? = nil
                for measurement in measurements {
                    if let currValue = measurement, let prevValue = previousMeasurement, currValue > prevValue {
                        measurementIncreases += 1
                    }
                    previousMeasurement = measurement
                }
                
                return measurementIncreases
            } catch {
                preconditionFailure("Error loading contents of input file")
            }
        } else {
            preconditionFailure("Cannot find input file")
        }
    }
}
