//: [Previous](@previous)

import Foundation

class Day4 {
    let calledNumbers: [Int]
    let boards: [[Int:(Int, Int)]]

    
    init() {
        do {
            if let inputUrl = Bundle.main.url(forResource: "day4-input", withExtension: "txt") {
                let inputString = try String(contentsOf: inputUrl)
                let lines = inputString.split{ $0.isNewline }
                
                calledNumbers = lines[0].split(separator: ",").compactMap{ Int($0) }
                
                var board = -1
                boards = lines[1..<lines.count]
                    .map({ line in
                        return line.split{ $0.isWhitespace }.compactMap{ Int($0) }
                    })
                    .enumerated()
                    .reduce([[Int:(Int, Int)]](repeating: [Int: (Int, Int)](), count: (lines.count - 1) / 5), { partialResult, curr in
                        var newResult = partialResult

                        if curr.0 % 5 == 0 {
                            board += 1
                        }
                        
                        for (idx, num) in curr.1.enumerated() {
                            newResult[board][num] = (curr.0 % 5, idx)
                        }
                        
                        
                        return newResult
                    })
            } else {
                preconditionFailure("Cannot find input file")
            }
        } catch {
            preconditionFailure("Error loading contents of input file: \(error)")
        }
    }
    
    func pt1() -> Int {
        var rowScores = [[Int]](repeating: [Int](repeating: 0, count: 5), count: boards.count)
        var columnScores = [[Int]](repeating: [Int](repeating: 0, count: 5), count: boards.count)
        var markedNumbers = [Set<Int>](repeating: Set<Int>(), count: boards.count)

        for calledNumber in calledNumbers {
            for (boardIdx, board) in boards.enumerated() {
                if let (col, row) = board[calledNumber] {
                    let rowScore = rowScores[boardIdx][row]
                    let columnScore = columnScores[boardIdx][col]
                    markedNumbers[boardIdx].insert(calledNumber)

                    if rowScore == 4 || columnScore == 4 {
                        var sumOfUnmarkedNumbers = 0
                        for (num, _) in boards[boardIdx] {
                            if !markedNumbers[boardIdx].contains(num) {
                                sumOfUnmarkedNumbers += num
                            }
                        }
                        
                        return calledNumber * sumOfUnmarkedNumbers
                    } else {
                        rowScores[boardIdx][row] += 1
                        columnScores[boardIdx][col] += 1
                    }
                }
            }
        }
        
        return 0
    }
    
    func pt2() -> Int {
        var rowScores = [[Int]](repeating: [Int](repeating: 0, count: 5), count: boards.count)
        var columnScores = [[Int]](repeating: [Int](repeating: 0, count: 5), count: boards.count)
        var markedNumbers = [Set<Int>](repeating: Set<Int>(), count: boards.count)
        var completedBoards = Set<Int>()

        for calledNumber in calledNumbers {
            for (boardIdx, board) in boards.enumerated() where !completedBoards.contains(boardIdx) {
                if let (col, row) = board[calledNumber] {
                    let rowScore = rowScores[boardIdx][row]
                    let columnScore = columnScores[boardIdx][col]
                    markedNumbers[boardIdx].insert(calledNumber)

                    if rowScore == 4 || columnScore == 4 {
                        completedBoards.insert(boardIdx)
                        
                        if completedBoards.count == boards.count {
                            var sumOfUnmarkedNumbers = 0
                            for (num, _) in boards[boardIdx] {
                                if !markedNumbers[boardIdx].contains(num) {
                                    sumOfUnmarkedNumbers += num
                                }
                            }
                            
                            return calledNumber * sumOfUnmarkedNumbers
                        }
                    } else {
                        rowScores[boardIdx][row] += 1
                        columnScores[boardIdx][col] += 1
                    }
                }
            }
        }
        
        return 0
    }
    
}

let day4 = Day4()
print("Day 4, part 1 output: ", day4.pt1())
print("Day 4, part 2 output: ", day4.pt2())

//: [Next](@next)
