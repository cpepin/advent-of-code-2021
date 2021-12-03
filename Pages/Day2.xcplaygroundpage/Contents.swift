//: [Previous](@previous)

import Foundation

enum Direction:String {
    case Down = "down"
    case Forward = "forward"
    case Up = "up"
    case Unknown = "unknown"
}

class Day2 {
    let commands: [(Direction, Int)]
    
    static func parseCommand(command: Substring) -> (Direction, Int) {
        let words = command.split{ $0.isWhitespace }
        
        return (Direction(rawValue: String(words[0])) ?? Direction.Unknown, Int(words[1]) ?? 0)
    }

    init() {
        commands = Utils.parseInput(inputUrl: "pt1-input").map{ Day2.parseCommand(command: $0) }
    }
    
    func pt1() -> Int {
        var horizontal = 0
        var depth = 0
        
        for (direction, val) in commands {
            switch direction {
            case .Up:
                depth -= val
            case .Down:
                depth += val
            case .Forward:
                horizontal += val
            default:
                break
            }
        }
        
        return horizontal * depth
    }
    
    func pt2() -> Int {
        var horizontal = 0
        var depth = 0
        var aim = 0
        
        for (direction, val) in commands {
            switch direction {
            case .Up:
                aim -= val
            case .Down:
                aim += val
            case .Forward:
                horizontal += val
                depth += (aim * val)
            default:
                break
            }
        }
        
        return horizontal * depth
    }
}

let day2 = Day2()

print("Day 2, part 1 answer: ", day2.pt1())
print("Day 2, part 2 answer: ", day2.pt2())

//: [Next](@next)
