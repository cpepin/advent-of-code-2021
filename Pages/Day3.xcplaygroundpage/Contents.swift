//: [Previous](@previous)

import Foundation

// rework intersection logic, correct answer: 1032597
// refactor bit shifting

enum Bit:Int {
    case one = 1
    case zero = 0
}

class Day3 {
    final let BIT_LENGTH = 12
    let numbers: [Int]
    
    static func nthBit(number: Int, n: Int) -> Bit? {
        return Bit(rawValue: (number >> n) & 1)
    }

    init() {
        numbers = Utils.parseInput(inputUrl: "day3-input").compactMap{ Int($0, radix: 2) }
    }
    
    func pt1() -> Int {
        var gammaRate = 0;
        var epsilonRate = 0;
        var bitCount = [Int](repeating: 0, count: BIT_LENGTH)

        for number in numbers {
            for bit in 0..<bitCount.count {
                if Day3.nthBit(number: number, n: bit) == Bit.one {
                    bitCount[bit] += 1
                } else {
                    bitCount[bit] -= 1
                }
            }
        }
        
        for bit in 0..<bitCount.count {
            if bitCount[bit] > 0 {
                // most common value was 1
                gammaRate |= 1 << bit
                epsilonRate |= 0 << bit
            } else {
                // most common value was 0
                gammaRate |= 0 << bit
                epsilonRate |= 1 << bit
            }
        }
        
        return gammaRate * epsilonRate
    }
    
    func pt2() -> Int {
        var potential02Values = Set(numbers)
        var potentialC02Values = Set(numbers)
        
        
        for bit in (0..<BIT_LENGTH).reversed() where potential02Values.count != 1 {
            var zeroBits: Set<Int> = []
            var oneBits: Set<Int> = []
            var bitCount = 0

            for potential02Value in potential02Values {
                if Day3.nthBit(number: potential02Value, n: bit) == Bit.one {
                    bitCount += 1
                    oneBits.insert(potential02Value)
                } else {
                    bitCount -= 1
                    zeroBits.insert(potential02Value)
                }
            }
            
            potential02Values.formIntersection(bitCount >= 0 ? oneBits : zeroBits)
        }
        
        for bit in (0..<BIT_LENGTH).reversed() where potentialC02Values.count != 1 {
            var zeroBits: Set<Int> = []
            var oneBits: Set<Int> = []
            var bitCount = 0

            for potentialC02Value in potentialC02Values {
                if Day3.nthBit(number: potentialC02Value, n: bit) == Bit.one {
                    bitCount += 1
                    oneBits.insert(potentialC02Value)
                } else {
                    bitCount -= 1
                    zeroBits.insert(potentialC02Value)
                }
            }
            
            potentialC02Values.formIntersection(bitCount >= 0 ? zeroBits : oneBits)
        }
        
        return (potential02Values.popFirst() ?? 0) * (potentialC02Values.popFirst() ?? 0);
    }
}

let day3 = Day3()

print("Day 3, part 1 solution: ", day3.pt1())
print("Day 3, part 2 solution: ", day3.pt2())

//: [Next](@next)
